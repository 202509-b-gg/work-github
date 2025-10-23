class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    @order = Order.find(params[:order_id])
    @order_detail = @order.order_details.find(params[:id])
    if @order_detail.update(order_detail_params)
      # どれか一つでも「製作中」なら注文ステータスを「製作中」に
      if @order.order_details.where(making_status: "in_making").exists?
        @order.update(status: "in_production")
      end
      # すべて「製作完了」なら注文ステータスを「発送準備中」に
      if @order.order_details.where.not(making_status: "complete_made").empty?
        @order.update(status: "preparing_for_shipping")
      end
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end