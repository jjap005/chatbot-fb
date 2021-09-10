
INDICATORS = %w[uf ivp dolar dolar_intercambio euro ipc utm imacec tpm libra_cobre tasa_desempleo bitcoin].freeze

class WelcomeController < ApplicationController

  def index
    @title = t('app.home')
  end

  def indicator
    @title = t('indicators.title')
    @indicator = INDICATORS.include? params[:indicator] ? JSON.parse(External::Mindicador.call(params[:indicator])) : []
  rescue
    @indicator = []
  end

  def indicators
    @title = t('indicators.title')
    @indicators = JSON.parse(External::Mindicador.call())
  end
end
