# OpenAiService Ruby Repository

This repository contains a Ruby service for translating text using the OpenAI GPT-4 model. The service is implemented as part of the PollyGlot AI project.

## OpenAiService

The `OpenAiService` class is responsible for interacting with the OpenAI API to perform translations. It includes error handling and utilizes the HTTParty gem for making HTTP requests.

### Usage

```ruby
# Example usage
service = OpenAiService.new
translation = service.translate("Hello, how are you?", "French")
puts "Translated Text: #{translation}"
```

### Front-end Project

[Pollyglot AI React](https://github.com/gsimei/pollyglot-app-react)

## API KEY

 To make it work, you will need insert your  OpenAI API key using the following command:

` EDITOR="nano" bin/rails credentials:edit`

Then, insert your API key with the variable. `chatgpt_api_key`

## Contributing

Feel free to contribute by opening issues or submitting pull requests. Contributions are always welcome

