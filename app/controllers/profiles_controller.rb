class ProfilesController < ApplicationController
  # User makes a GET request to /users/:user_id/profile/new
  def new
    # Render a blank profile form
    @profile = Profile.new
  end
end