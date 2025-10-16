class Public::CustomersController < ApplicationController
  # ログイン必須
  # before_action :authenticate_customer!  

  def show
  end

  def edit
  end

  def updated
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def customer_params
  params.require(:customer)
        .permit(:last_name, :first_name, 
                :last_name_kana, :first_name_kana, 
                :postal_code, :address, 
                :telephone_number, :is_active,)
  end
end
