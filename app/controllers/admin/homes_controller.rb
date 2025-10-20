class Admin::HomesController < ApplicationController
  def top
    @orders = Order.includes(:customer).order(created_at: :desc).page(params[:page]).per(10)
  end
end
