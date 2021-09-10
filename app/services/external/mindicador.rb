require 'rest-client'

module External
  class Mindicador < ApplicationService
    class MissingIndicatorError < StandardError
    end
    class ServerUnavailableError < StandardError
    end

    BASE_URL = 'https://mindicador.cl/api'.freeze

    def initialize(indicator)
      @indicator = indicator
    end

    def call
			raise MissingIndicatorError if @indicator.nil?

			response = RestClient.get("#{BASE_URL}/#{@indicator}")
      json = JSON.parse(response)

      data = {
        name: json['nombre'],
        code: json['codigo'],
        value: json['serie'][0]['valor'],
        units: json['unidad_medida']
      }
    rescue => e
      raise ServerUnavailableError, "Error processing request, #{e.message}"
    end
  end
end
