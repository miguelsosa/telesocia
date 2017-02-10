class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # All pages except home pages require authentication
  before_action :authenticate_user!

  before_filter :redirect_if_old
  protected

  def redirect_if_old
    if request.host == 'www.telesocia.com'
      redirect_to "#{request.protocol}telesocia-dev.herokuapp.com#{request.fullpath}", :status => :moved_permanently 
    end
  end
endend
