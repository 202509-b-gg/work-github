class Public::CustomersController < ApplicationController
  # ログイン必須
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "会員情報の更新が完了しました。"
      redirect_to my_page_path
    else
      flash.now[:alert] = "会員情報の更新が失敗しました。"
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    if @customer.update(is_active: false)
      flash[:notice] = "退会処理が完了しました。"
      # セッションをクリアしてログアウトさせる
      reset_session
      redirect_to root_path
    else
      flash.now[:alert] = "退会処理が失敗しました。"
      render :unsubscribe
    end
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
