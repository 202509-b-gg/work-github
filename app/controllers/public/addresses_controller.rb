class Public::AddressesController < ApplicationController
  # ログイン必須
  # before_action :authenticate_customer! 

  def index
    @customer = current_customer
    @addresses = @customer.addresses
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      render 'index'
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render 'edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      redirect_to addresses_path
    else
      render 'index'
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :recipient_name)
  end
end
