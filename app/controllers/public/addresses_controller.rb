class Public::AddressesController < ApplicationController
  # ログイン必須
  # before_action :authenticate_customer! 

  def index
    @customer = current_customer
    @addresses = @customer.addresses
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to address_path
    else
      render 'index'
    end
  end

  def update
  end

  def destroy
  end

  private

  def address_params
    params.permit(:postal_code, :address, :recipient_name)
  end
end
