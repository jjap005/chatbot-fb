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
    founds = Found.where(user_id: current_user.id)
    found_date = founds.find_by(date_receipt: params[:search])
    found_number = founds.find_by(receipt_number: params[:search])

    if found_date.nil? && found_number.nil?
      render json: { error: true, msg: 'Registro no encontrado' }
    else

      if found_number.nil?
        render json: { error: false, msg: "Registro encontrado, el saldo consultado es #{found_date.amount}, de fecha #{found_date.date_receipt.strftime('%d/%m/%Y')}" }
      else
        render json: { error: false, msg: "Registro encontrado, el saldo consultado es #{found_number.amount} de fecha #{found_number.date_receipt.strftime('%d/%m/%Y')}" }
      end
    end
  end

  private
  def founds_params
    params.permit(:date_receipt , :amount, :receipt_number )
  end
end
