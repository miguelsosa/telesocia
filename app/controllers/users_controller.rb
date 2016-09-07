class UsersController < ApplicationController
  respond_to :html, :json

  # Just index and show. The rest of the activities are controlled by devise
  # TODO: Once we add groups, this should show only users with a particular visibility

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end

end
