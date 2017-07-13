class UsersController < ApplicationController
  # When user makes GET request to /users/:id
  def show
    @user = User.find(params[:id])
  end
end