class ApplicationController < ActionController::Base
  http_basic authenticate_with :name => "katsuya", :password => "kA141913" if Rails.env == "production"
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:after_sign_in_path_for]

  def after_sign_in_path_for(resource)
    admin_path
  end
end
