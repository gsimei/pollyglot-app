class Api::V1::TranslationsController < ApplicationController

  def create
    service = OpenAiService.new
    translations = service.translate(translation_params[:text], translation_params[:language])
    render json: {translations: translations}
  rescue StandardError => e
    render json: {error: e.message}, status: :unprocessable_entity
  end

    def translation_params
      params.require(:translation).permit(:text, :language)
    end
end
