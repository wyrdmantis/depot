class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # allow creation of admin account if none is set
  before_action :authorize, unless: lambda { User.no_admins? }

  protected

  def authorize
    redirect_to login_url, notice: "Please log in" unless User.find_by(id: session[:user_id])
  end
end
