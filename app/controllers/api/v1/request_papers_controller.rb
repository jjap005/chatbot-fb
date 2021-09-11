class Api::V1::RequestPapersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def request_paper
    request_paper = RequestPaper.new(request_paper_params)

    if request_paper.save
      render json: { error: false, msg: 'Registro guardado con exito' }
    else
      render json: { error: true, msg: 'No fue posible guardar el registro', errors: request_paper.errors.full_messages.to_s }
    end
  end

  private

  def request_paper_params
    params.permit(:rut, :address, :count)
  end
end
