class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:after_sign_in_path_for]
  before_filter :basic

  def after_sign_in_path_for(resource)
    admin_path
  end

  private
  def basic
    authenticate_or_request_with_http_basic do |name, password| 
      name == "katsuya" && password == "kA141913"
    end
  end
end
