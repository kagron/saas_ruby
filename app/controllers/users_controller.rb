class UsersController < ApplicationController
  before_action :authenticate_user!
  
  # When user makes GET request to /users/:id
  def show
    @user = User.find(params[:id])
  end
end