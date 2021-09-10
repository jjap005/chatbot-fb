module External
  class Mindicador < ApplicationService
    require 'rest-client'

    def initialize(params="")
      @url = 'https://mindicador.cl/api'.freeze
      @params = params
    end

    def call(params="")
      indicator = JSON.parse(RestClient.get "#{@url}/#{@params}")

      data = {
        name: indicator['nombre'],
        code: indicator['codigo'],
        value: indicator['serie'][0]['valor'],
        units: indicator['unidad_medida']
      }
    end
  end
end
