class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # All pages except home pages require authentication
  before_action :authenticate_user!
  force_ssl if: :ssl_required?
  private
  def ssl_required?
    request.host == 'telesocia-dev.herokuapp.com'
  end
end
