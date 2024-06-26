# frozen_string_literal: true

require_relative "ollama_client/configuration"
require_relative "ollama_client/generate"
require_relative "ollama_client/version"

# ollama client
module OllamaClient
  class Error < StandardError; end
  class RequestError < StandardError; end

  class << self
    attr_writer :configuration

    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def generate(options = {}, &block)
      Generate.new(options).call(&block)
    end
  end
end
