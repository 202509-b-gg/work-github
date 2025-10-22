class Public::AddressesController < ApplicationController
  # ログイン必須
  before_action :authenticate_customer! 

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
      flash[:notice] = "配送先の登録が完了しました。"
      redirect_to addresses_path
    else
      @customer = current_customer
      @addresses = @customer.addresses
      flash.now[:alert] = "配送先の登録に失敗しました。"
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "配送先の更新が完了しました"
      redirect_to addresses_path
    else
      flash.now[:alert] = "配送先の更新が失敗しました。"
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      flash[:notice] = "配送先の削除が完了しました。"
      redirect_to addresses_path
    else
      flash.now[:alert] = "配送先の削除が失敗しました。"
      render :index
    end
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :recipient_name)
  end
end
