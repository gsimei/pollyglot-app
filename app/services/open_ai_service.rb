class OpenAiServiceError < StandardError
end
class OpenAiService
  include HTTParty

  attr_reader :api_url, :options, :model, :message

  def initialize
    api_key = Rails.application.credentials.chatgpt_api_key
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}"
      }
    }
    @api_url = 'https://api.openai.com/v1/chat/completions'
  end

  def translate(text, language)
    body = {
      model: 'gpt-4',
      messages: messages(text, language),
      temperature: 1.1,
      max_tokens: 150,
    }

    response = HTTParty.post(@api_url, body: body.to_json, headers: @options[:headers], timeout: 10)

    if response.success?
      response.parsed_response['choices'].first['message']['content'].strip
    else
      raise OpenAiServiceError, "OpenAI Error: #{response.code} #{response.message}"
    end
  rescue StandardError => e
    raise OpenAiServiceError.new(e.message, e)
  end

  private

  def messages(text, language)
    [
      {
        role: 'system',
        content: "Translate for the #{language} language, i want just the translation"
      },
      {
        role: 'user',
        content: text
      }
    ]
  end
end
