class CustomersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @title = t('customers.title')

  end


end
