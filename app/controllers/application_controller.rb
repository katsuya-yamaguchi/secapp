class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:after_sign_in_path_for]

  def after_sign_in_path_for(resource)
    admins_path
  end
end
