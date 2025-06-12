# frozen_string_literal: true
module Api
  class AttachmentsController < ApplicationController
    def destroy
      @attachment = ActiveStorage::Attachment.find(params[:id])
      @attachment.purge

      redirect_to redirect_path, flash: { notice: "Attachment was successfully deleted" }
    end

    private

    def redirect_path
      case @attachment.record_type
      when "Recipe"
        edit_recipe_path(@attachment.record)
      when "BlogPost"
        edit_blog_post_path(@attachment.record)
      else
        root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:id)
    end
  end
end
