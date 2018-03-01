class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:after_sign_in_path_for]

  def after_sign_in_path_for(resource)
    mypage_path
  end

  private
  def sign_in_required
    redirect_to new_user_session unless user_signed_in?
  end
end
