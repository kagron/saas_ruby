class ProfilesController < ApplicationController
  # User makes a GET request to /users/:user_id/profile/new
  def new
    # Render a blank profile form
    @profile = Profile.new
  end
  # User submits POST request to /users/:user_id/profile
  def create
    # Ensure that we have the user who is filling out form
    @user = User.find( params[:user_id])
    # Create profile linked to logged in user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to root_path
    else
      render action: :new
    end
  end
  
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
    end
end