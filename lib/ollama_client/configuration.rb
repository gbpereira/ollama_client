# frozen_string_literal: true

module OllamaClient
  # client configuration
  class Configuration
    attr_accessor :url, :model

    def initialize(model: nil, url: nil)
      @model = model
      @url = url
    end
  end
end
