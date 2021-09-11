class Api::V1::FoundsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def add_found
    found = current_user.founds.build(founds_params)

    if found.save
      render json: { error: false, msg: 'Registro guardado con exito' }
    else
      render json: { error: true, msg: "No fue posible guardar el registro #{found.errors.full_messages}" }
    end
  end

  def search_found
    result = data_records(params[:rut], params[:date])

    return render json: { error: true, msg: 'Registro no encontrado para los parametros indicados' } if result.zero?

    render json: { error: false, msg: "El saldo que se posee para los parametros consultados es: #{result}" }
  end

  private

  def founds_params
    params.permit(:date, :amount, :number, :rut)
  end

  def data_records(rut, date)
    founds = Found.where(rut: rut, date: date)
    founds.sum(:amount)
  end
end
