class CollectionsController < ApplicationController
  before_action :set_collection, only: %i[ show edit update destroy ]
  before_action :authenticate, only: %i[ index new edit create update destroy ]

  # GET /collections or /collections.jsons
  def index
    @collections = Collection.all
  end

  # GET /collections/1 or /collections/1.json
  def show
    @entries = @collection.entries

    @introduction_paragraphs = @collection.introduction_paragraphs.map do |paragraph|
      MarkdownConverter.convert(paragraph)
    end

    @entries
  end

  # GET /collections/new
  def new
    @entries = []
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
    @entries = @collection.entries
  end

  # POST /collections or /collections.json
  def create
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        format.html { redirect_to collection_url(@collection), notice: "Entry collection was successfully created." }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1 or /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to collection_url(@collection), notice: "Entry collection was successfully updated." }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1 or /collections/1.json
  def destroy
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to collections_url, notice: "Entry collection was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_collection
    @collection = Collection.find_by_id(params[:id]) || collection_by_permalink
  end

  def collection_by_permalink
    @collection = Collection.all.find do |collection|
      collection.permalink == "/#{params['collection_path']}" ||
        collection.permalink == "/#{params[:id]}"
    end
  end

  # Only allow a list of trusted parameters through.
  def collection_params
    entries = Entry.where(id: JSON.parse(params[:entries]))
    params.require(:collection).permit(
      :title,
      :introduction,
      :entries,
      :published_at).merge({
        entries: entries,
        published_at: Date.parse(params[:collection][:published_at])
      })
  end
end
