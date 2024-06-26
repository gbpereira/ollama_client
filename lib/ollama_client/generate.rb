# frozen_string_literal: true

require "net/http"
require "json"

module OllamaClient
  # generate api
  class Generate
    def initialize(options = {})
      @options = options
    end

    def call(&block)
      request = ::Net::HTTP::Post.new(uri, **headers)
      request.body = params

      do_request(request, &block)
    rescue StandardError => e
      puts "ERROR: #{e.class}\nMESSAGE: #{e.message}\nBACKTRACE: #{e.backtrace.first}"
    end

    private

    def do_request(request, &block)
      response = []

      ::Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request) do |partial_response|
          partial_response.read_body do |chunk|
            json = JSON.parse(chunk, symbolize_names: true)

            block ? block&.call(json) : response << json
          end
        end
      end

      response unless block
    end

    def headers
      { 'Content-type': "application/json", 'Accept': "application/json" }
    end

    def params
      {
        model: OllamaClient.configuration.model,
        stream: true
      }.merge(@options).to_json
    end

    def uri
      base_url = @options.fetch(:url, OllamaClient.configuration.url)

      URI("#{base_url}/api/generate")
    end
  end
end
