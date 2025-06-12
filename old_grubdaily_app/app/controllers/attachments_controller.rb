class AttachmentsController < ApplicationController

  before_action :set_attachment

  def edit; end

  def update
    respond_to do |format|
      if @attachment.update!(attachment_params)
        format.html { redirect_to edit_polymorphic_url(attachable), notice: 'Attachment successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
  end

  def attachable
    @attachment.record_type.constantize.find(@attachment.record_id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attachment_params
    params.require(:attachment).permit(:id, :caption)
  end
end
