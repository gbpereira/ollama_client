# OllamaClient - WORK IN PROGRESS

Ruby client for self-hosted [Ollama LLM](https://github.com/ollama/ollama)

## Usage
- Optional setup, you can overwrite the default config arguments during requests
```ruby
OllamaClient.configure do |config|
  config.url = "http://localhost:11434"
  config.model = "llama3"
end
```


- Generate completion API

Generate a request (stream). By default, all requests are made in `stream` mode
```ruby
OllamaClient.generate(prompt: '<prompt>')
```


Alternatively, you can pass a block
```ruby
OllamaClient.generate(prompt: '<prompt>', model: '<model_name>', url: '<ollama_url>') do |stream|
  print stream[:response]
end
```


This client is only a wrapper and `prompt` is the only required attribute. Check the Ollama [documentation](https://github.com/ollama/ollama/blob/main/docs/api.md#generate-a-completion) to see all possibilites.
