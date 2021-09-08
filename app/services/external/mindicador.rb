module External
  class Mindicador < ApplicationService
    require 'rest-client'

    def initialize(params="")
      @url = 'https://mindicador.cl/api'.freeze
      @params = params
    end

    def call(params="")
      RestClient.get "#{@url}/#{@params}"
    end
  end
end
