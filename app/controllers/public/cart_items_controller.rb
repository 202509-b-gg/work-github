class Public::CartItemsController < ApplicationController

  before_action :authenticate_user!
  
  def index
  end
  def create
    # 1. 現在のユーザーのカートを取得
    #   (ApplicationControllerなどで`current_cart`メソッドを定義している想定)
    @cart = current_user.cart || current_user.create_cart

    # 2. カート内に既に同じ商品があるか確認
    @cart_item = @cart.cart_items.find_by(item_id: params[:cart_item][:item_id])

    if @cart_item
      # 3. 商品が既にカートにあれば、数量を追加して更新
      new_quantity = @cart_item.quantity + params[:cart_item][:quantity].to_i
      @cart_item.update(quantity: new_quantity)
      flash[:notice] = "#{@cart_item.item.name}の数量を変更しました。"
    else
      # 4. カートに新しい商品として追加
      @cart_item = @cart.cart_items.build(cart_item_params)
      if @cart_item.save
        flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
      else
        flash[:alert] = "カートへの追加に失敗しました。"
        # 失敗した場合は商品詳細ページに戻る
        redirect_to item_path(params[:cart_item][:item_id]) and return
      end
    end

    # 5. カートページにリダイレクト
    redirect_to cart_path(@cart)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end