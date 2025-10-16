class Public::AddressesController < ApplicationController
  # ログイン必須
  # before_action :authenticate_customer! 

  def index
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def customer_params
  params.require(:address).permit(:recipient_name, :postal_code, :address)
  end
end
