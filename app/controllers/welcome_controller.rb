class WelcomeController < ApplicationController

  def index
    @title = t('app.home')

  end

  def indicator
    indicators = %w[uf ivp dolar dolar_intercambio euro ipc utm imacec tpm libra_cobre tasa_desempleo bitcoin]

    if indicators.include? params[:indicator]
      begin
        @indicator = JSON.parse(External::Mindicador.call(params[:indicator]))
      rescue
        @indicator = []
      end
    else
      @indicator = []
    end
  end

  def indicators
    @indicators = JSON.parse(External::Mindicador.call())
  end
end
