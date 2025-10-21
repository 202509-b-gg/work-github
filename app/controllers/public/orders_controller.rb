class Public::OrdersController < ApplicationController   
  before_action :authenticate_customer!
  
  def new
  end
  
  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @shipping_cost = 800 #送料は800円で固定
    @selected_payment_method = params[:payment_method]
    

    ary = []
    @cart_items.each do |cart_item|
      ary << cart_item.item.price * cart_item.amount
    end
    @cart_items_price = ary.sum
    
    @total_payment = @shipping_cost + @cart_items_price
    @address_type = params[:address_type]
    case @address_type
    when "customer_address"
      @selected_address = current_customer.postal_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name
    when "address"
      unless params[:address_id] == ""
        selected = Address.find(params[:address_id])
        @selected_address = selected.postal_code + " " + selected.address + " " + selected.recipient_name
      else	 
        render :new
      end
    when "new_address"
      unless params[:new_postal_code] == "" && params[:new_address] == "" && params[:new_recipient_name] == ""
        @selected_address = params[:new_postal_code] + " " + params[:new_address] + " " + params[:new_recipient_name]
      else
        render :new
      end
    end     
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @cart_items = CartItem.where(customer_id: current_customer.id)
    ary = []
    @cart_items.each do |cart_item|
      ary << cart_item.item.price * cart_item.amount
    end
    @cart_items_price = ary.sum
    @order.total_payment = @order.shipping_cost + @cart_items_price
  
    @order.payment_method ||= "credit_card"
  
    if @order.payment_method == "credit_card"
      @order.status = "payment_confirmed"
    else
      @order.status = "waiting_for_payment"
    end
    
    address_type = params[:order][:address_type]
    case address_type
    when "customer_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    when "address"
      selected = Address.find(params[:order][:address_id])
      @order.postal_code = selected.postal_code
      @order.address = selected.address
      @order.name = selected.recipient_name
    when "new_address"
      @order.postal_code = params[:order][:new_postal_code]
      @order.address = params[:order][:new_address]
      @order.name = params[:order][:new_recipient_name]
    end
    
    if @order.save
      if @order.status == "waiting_for_payment"
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 0)
        end
      else
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 1)
        end
      end
      @cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      render :items
    end
  end
  
  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc).page(params[:page]).per(10)
  end
  

  def show
    # idが数字以外なら404
    unless params[:id].to_s =~ /\A\d+\z/
      render file: Rails.root.join('public', '404.html'), status: :not_found and return
    end
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end
  
  def thanks
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
  
end
