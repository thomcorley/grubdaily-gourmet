class ImageUploadsController < ApplicationController
  before_action :set_image_upload, only: [:show, :edit, :create, :update, :destroy, :as_yaml]

  before_action :authenticate, except: [:show]

  def index
    @image_uploads = ImageUpload.all
  end

  def show
  end

  def new
    @image_upload = ImageUpload.new
  end

  def create
    @image_upload = ImageUpload.new(image_upload_params)

    if @image_upload.save
      redirect_to @image_upload, notice: 'Image upload was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @image_upload.update(image_upload_params)
      redirect_to @image_upload, notice: 'Image upload was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @image_upload.destroy
    redirect_to image_uploads_url, notice: 'Image upload was successfully destroyed.'
  end

  def as_yaml
    render plain: @image_upload.as_yaml
  end

  private

  def set_image_upload
    if params["image_upload_path"]
      @image_upload = ImageUpload.all.find do |image_upload|
        image_upload.permalink == "/#{params["image_upload_path"]}"
      end
    elsif params[:id]
      @image_upload = ImageUpload.find(params[:id])
    end
  end

  def image_upload_params
    params.require(:image_upload).permit(
      :title,
      :description,
      :website_url,
      :published_at,
      :image
    )
  end
end
