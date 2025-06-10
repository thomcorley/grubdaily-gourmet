class BlogPostsController < ApplicationController
  include ApplicationHelper

  before_action :set_blog_post, only: [
    :show, :edit, :update, :destroy, :publish, :unpublish
  ]

  before_action :authenticate, except: [:index, :show, :feed]

  def index
    @blog_posts = BlogPost.published.order(created_at: :desc).limit(12)
    fresh_when(@blog_posts)
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    tags = blog_post_params['tag_names']
    @blog_post = BlogPost.new(blog_post_params.except('tag_names'))

    respond_to do |format|
      if @blog_post.save
        find_or_create_entry
        expire_blog_post_caches
        @blog_post.process_image_variants

        format.html { redirect_to @blog_post, notice: 'Blog Post was successfully created.' }
        format.json { render :show, status: :created, location: @blog_post }
      else
        format.html { render :new }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @tags = @blog_post.tags
    @prev_post = BlogPost.find_by_id(@blog_post.id - 1)
    @next_post = BlogPost.find_by_id(@blog_post.id + 1)
    @subscriber_count = subscriber_count

    @other_blog_posts = BlogPost.published
                                .where.not(id: @blog_post.id)
                                .offset(rand(BlogPost.published.count - 1))
                                .limit(4)

    fresh_when(@blog_post)
  end

  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params.except('tag_names'))
        find_or_create_entry
        expire_blog_post_caches
        @blog_post.process_image_variants

        format.html { redirect_to @blog_post, notice: 'Blog Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog_post }
      else
        format.html { render :edit }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish
    @blog_post.publish!
    redirect_to blog_post_path(@blog_post), flash: { notice: "Blog post successfully published!" }
  end

  def unpublish
    @blog_post.unpublish!
    redirect_to blog_post_path(@blog_post), flash: { notice: "Blog post unpublished" }
  end

  def destroy
    @blog_post.destroy
    redirect_to recipe_index_path, flash: { notice: "Blog post was successfully deleted" }
  end

  def feed
    @blog_posts = BlogPost.published
                          .where("published_at <= ?", Date.today.beginning_of_day)
                          .order(published_at: :desc)

    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def more_blog_posts
    @page = params[:page] || 1
    offset = @page.to_i * 12

    blog_posts = BlogPost.published
                         .order(created_at: :desc)
                         .offset(offset)
                         .limit(12)

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.append("truncated-blog-post-list",
            partial: "shared/entry_list",
            locals: {
              entries: blog_posts
            }
          ),
          turbo_stream.replace("load-more-button",
            partial: "shared/load_more_button",
            locals: {
              path: more_blog_posts_path(page: @page.to_i + 1),
              button_text: "Load more posts"
            }
          )
        ]
      }
    end
  end

  private

  def authenticate
    not_found unless admin_session?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_post_params
    params.require(:blog_post).permit(
      :title, :summary, :content, :tag_names, :published_at, attached_images: []
    )
  end

  def entry_params
    params.require(:blog_post).permit(
      :title,
      :summary,
      :content,
      :published_at
    )
  end

  def set_blog_post
    # Confusingly, `recipe_title` is usually the permalink of the recipe, but sometimes the ID
    if params["blog_post_path"]
      @blog_post = BlogPost.all.find { |blog_post| blog_post.permalink == "/posts/#{params["blog_post_path"]}" }
    elsif params[:id]
      @blog_post = BlogPost.find(params[:id])
    end
  end

  def expire_blog_post_caches
    Rails.cache.delete("home_index")
    Rails.cache.delete("sitemap_entries")
    expire_tags
    Rails.cache.delete("blog_post_#{@blog_post.id}")
    Rails.cache.delete_matched("blog_post_*")
  end

  def expire_tags
    @blog_post.tags.map(&:name).each do |tag_name|
      Rails.cache.delete("tag_#{tag_name}")
    end
  end

  def find_or_create_entry
    entry = Entry.find_or_create_by!(entryable: @blog_post)
    entry.update(entry_params)
    entry.tags = blog_post_params['tag_names']
  end
end
