class Api::V1::FoundsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def add_found

    found = Found.new

    found.date_receipt = params[:date_receipt]
    found.amount = params[:amount]
    found.receipt_number = params[:receipt_number]
    found.user_id = current_user.id

    if found.save
      render :json => {error: false, msg: 'Registro guardado con exito'}
    else
      render :json => {error: true, msg: "No fue posible guardar el registro #{found.errors.full_messages}"}
    end

  end

  def search_found
    founds = Found.where(user_id: current_user.id)
    found_date = founds.where('CAST(date_receipt AS text) LIKE ?', params[:search]).limit(1)
    found_number = founds.where(:receipt_number => params[:search]).limit(1)

    if found_date.empty? && found_number.empty?
      render :json => {error: true, msg: 'Registro no encontrado'}
    else
      if found_date.any?
        render :json => {error: false, msg: "Registro encontrado, el saldo consultado es #{found_date[0].amount}, de fecha #{found_date[0].date_receipt.strftime('%d/%m/%Y')}"}
      else
        render :json => {error: false, msg: "Registro encontrado, el saldo consultado es #{found_number[0].amount} de fecha #{found_number[0].date_receipt.strftime('%d/%m/%Y')}"}
      end
    end
  end

end
