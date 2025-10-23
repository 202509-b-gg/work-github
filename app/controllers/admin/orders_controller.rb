class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.includes(:item)
  end

  def update
    @order = Order.find(params[:id])
    prev_status = @order.status # 更新前のステータスを保持
    if @order.update(order_params)
      # 入金確認になったら、全ての製作ステータスを製作待ちに
      if @order.status == "payment_confirmed" && prev_status != "payment_confirmed"
        @order.order_details.each do |order_detail|
          order_detail.update(making_status: "waiting_for_making")
        end
      end
      # 製作中・製作完了の自動反映もorder_detail更新時にするため、ここでは不要
    end
    redirect_to admin_order_path(@order)
  end

  def index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders.order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
