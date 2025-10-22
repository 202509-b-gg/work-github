class Admin::CustomersController < ApplicationController
  # ログイン必須
  before_action :authenticate_admin!

  def index
    @customers = Customer.order(:id).page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました。"
      redirect_to admin_customer_path(@customer)
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  private

  def customer_params
  params.require(:customer)
        .permit(:last_name, :first_name, 
                :last_name_kana, :first_name_kana, 
                :postal_code, :address, 
                :telephone_number, :email, :is_active,)
  end
end
