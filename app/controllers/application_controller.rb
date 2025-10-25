class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_q

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :last_name, :first_name, :last_name_kana, :first_name_kana,
      :postal_code, :address, :telephone_number
    ])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :last_name, :first_name, :last_name_kana, :first_name_kana,
      :postal_code, :address, :telephone_number
    ])
  end

  # Ransackオブジェクトを用意する
  private

  def set_q
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end
end
