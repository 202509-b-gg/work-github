class Admin::OrderDetailsController < ApplicationController
  def update
    @order = Order.find(params[:order_id])
    @order_detail = @order.order_details.find(params[:id])
    if @order_detail.update(order_detail_params)
      if @order_detail.making_status == "production_completed"
        if @order.order_details.where.not(making_status: "production_completed").empty?
          @order.update(status: "ready_for_shipping")
        end
      end
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end