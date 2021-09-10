class Api::V1::MindicadorsController < ApplicationController
  def indicator
    indicators = %w[uf dolar utm]

    if indicators.include? params[:indicator]
      begin
        indicator = JSON.parse(External::Mindicador.call(params[:indicator]))

        data = {
          name: indicator['nombre'],
          code: indicator['codigo'],
          value: indicator['serie'][0]['valor'],
          units: indicator['unidad_medida']
        }

        @indicator = { error: false, msg: data }
      rescue => exception

        puts exception
        @indicator = { error: true, msg: t('indicator.no_exist') }
      end
    else
      @indicator = { error: true, msg: t('indicator.no_exist') }
    end

    render :json => @indicator
  end
end
