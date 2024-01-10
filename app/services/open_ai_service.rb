class OpenAiService
  include HTTParty
  base_uri 'https://api.openai.com/v1/chat/completions'

  def initialize
    @headers = {
      'Authorization' => "Bearer #{ENV['OPENAI_API_KEY']}",
      'Content-Type' => 'application/json'
    }
    binding.irb
  end

  def translate(text, target_language)
    body = {
      model: 'gpt-4',
      messages: messages(text, target_language),
      temperature: 0.3,
      max_tokens: 150,
      frequency_penalty: 0.5,
      presence_penalty: 0.5
    }.to_json

    response = self.class.post('/engines/davinci-codex/completions', body: body, headers: @headers)

    if response.success?
      response.parsed_response['choices'].first['text'].strip
    else
      raise "OpenAI Error: #{response.code} #{response.message}"
    end
  rescue StandardError => e
    # Handle the exception (log it, notify, etc.)
    raise e.message
  end

  private

  def messages(text, target_language)
    [
      {
        role: 'system',
        content: "You will be a translator from the language that you will detect
                  using your language pattern, for the #{target_language} language."
      },
      {
        role: 'user',
        content: text
      }
    ].to_json
  end
end
