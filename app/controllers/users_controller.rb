class UsersController < ApplicationController
  respond_to :html, :json

  # Just index and show. The rest of the activities are controlled by devise
  # TODO: Once we add groups, this should show only users with a particular visibility

  def index
    @users = current_user.visible_users
  end

  def show
    @user = current_user.show_user(params[:id])
    respond_with(@user)
  end

end
