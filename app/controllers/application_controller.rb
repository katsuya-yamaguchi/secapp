class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:after_sign_in_path_for]
  before_action :get_current_user_info

  def after_sign_in_path_for(resource)
    if current_user.email == "ka.yamaguchi.3@gmail.com"
      admin_path
    else
      mypage_path
    end
  end

  private
  def sign_in_required
    redirect_to new_user_session_path unless user_signed_in?
  end

  def get_current_user_info
    @current_user_name = String.new
    if ! (current_user.nil?)
      if ! (current_user.email == "")
        @current_user_name = current_user.email.split("@")[0]
      elsif ! (current_user.username.nil?)
        @current_user_name = current_user.username
      else
        @current_user_name = ""
      end
    end
  end
end
