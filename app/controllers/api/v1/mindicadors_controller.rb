INDICATORS = %w[uf dolar utm].freeze

class Api::V1::MindicadorsController < ApplicationController
  def indicator
    return render json: { error: true, msg: t('indicator.no_exist') } unless INDICATORS.include? params[:indicator]

    data = External::Mindicador.call(params[:indicator])
    render json: { error: false, msg: data }
  rescue StandardError
    render json: { error: true, msg: t('indicator.error_present') }
  end
end
