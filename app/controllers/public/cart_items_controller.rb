class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!
  
  def index
    @cart_items = CartItem.all
  end
  def create
    # 1. パラメータから渡された商品を、ログイン中の顧客のカートアイテムから探す
    @item = Item.find(params[:cart_item][:item_id])
    @cart_item = current_customer.cart_items.find_by(item_id: @item.id)
    if @cart_item
      # 2. カートアイテムが既に存在する場合 (同じ商品がカートにある場合)
      #   フォームから送られてきた数量を既存の数量に加算する
      new_amount = @cart_item.amount + params[:cart_item][:amount].to_i
      @cart_item.update(amount: new_amount)
      flash[:notice] = "#{@cart_item.item.name}の数量を変更しました。"
    else
      # 3. カートアイテムが存在しない場合 (カートにない新しい商品の場合)
      #   顧客に紐づいた新しいカートアイテムを作成する
      @cart_item = current_customer.cart_items.new(
      item_id: @item.id,
      amount: params[:cart_item][:amount].to_i,
      )
      unless @cart_item.save
        # 保存に失敗した場合の処理
        flash[:alert] = "カートへの追加に失敗しました。"
        redirect_to item_path(params[:cart_item][:item_id]) and return
      end
      flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
    end
    # 4. 処理成功後、カートアイテム一覧ページにリダイレクト
    redirect_to cart_items_path # cart_itemsのindexページへのパスを想定
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items
      render :index
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: "カートを空にしました。"
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amout)
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end