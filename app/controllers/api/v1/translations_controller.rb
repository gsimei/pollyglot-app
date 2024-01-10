class Api::V1::TranslationsController < ApplicationController

    def create
      translations = OpenAiService.new.translate(params[:text], params[:target_language])
      render json: {translations: translations}
    rescue StandardError => e
      render json: {error: e.message}, status: :unprocessable_entity
    end

    def translation_params
      params.require(:translation).permit(:text, :language)
    end
end
