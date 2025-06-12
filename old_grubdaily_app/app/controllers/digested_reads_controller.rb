class DigestedReadsController < ApplicationController
  before_action :set_digested_read, only: %i[ show edit update destroy ]
  before_action :set_placeholder, only: %i[ new edit ]
  before_action :authenticate, only: [
    :show, :index, :edit, :update, :destroy, :create, :new
  ]

  # GET /digested_reads or /digested_reads.json
  def index
    @digested_reads = DigestedRead.all
  end

  # GET /digested_reads/1 or /digested_reads/1.json
  def show
    @tags = @digested_read.tags.split(",")
  end

  # GET /digested_reads/new
  def new
    @placeholder_content = placeholder_content
    @digested_read = DigestedRead.new
  end

  # GET /digested_reads/1/edit
  def edit
  end

  # POST /digested_reads or /digested_reads.json
  def create
    tags = digested_read_params.delete(:tags)
    @digested_read = DigestedRead.new(digested_read_params)

    respond_to do |format|
      if @digested_read.save
        @digested_read.tags = tags

        format.html { redirect_to @digested_read, notice: "Digested read was successfully created." }
        format.json { render :show, status: :created, location: @digested_read }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @digested_read.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /digested_reads/1 or /digested_reads/1.json
  def update
    respond_to do |format|
      if @digested_read.update(digested_read_params)
        format.html { redirect_to @digested_read, notice: "Digested read was successfully updated." }
        format.json { render :show, status: :ok, location: @digested_read }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @digested_read.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /digested_reads/1 or /digested_reads/1.json
  def destroy
    @digested_read.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Digested read was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def feed
    @digested_reads = DigestedRead.published.order(published_at: :desc)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private

  def set_digested_read
    # Confusingly, `digested_read` is usually the permalink of the recipe, but sometimes the ID
    if params[:digested_read_path]
      @digested_read = DigestedRead.all.find { |digested_read| digested_read.permalink == "/digested/#{params[:digested_read_path]}" }
    elsif params[:id]
      @digested_read = DigestedRead.find(params[:id])
    end
  end

  # Only allow a list of trusted parameters through.
  def digested_read_params
    params.fetch(:digested_read, {}).permit(
      :title, :image, :summary, :content, :tags, :published_at, :book_cover, :affiliate_link, :author_info
    )
  end

  def set_placeholder
    @placeholder ||= placeholder_content
  end

  def placeholder_content
    <<~MSG
      NOTE: Follow this format!

      Example content content example content content
      example content example content example content
      example content example content example content

      ---

      Example content example content example content
      example content example content example content
      example content example content example content

      > Example quote Example quote Example quote
      Example quote Example quote Example quote

      Example content example content example content
      example content example content example content
      example content example content example content
    MSG
  end
end
