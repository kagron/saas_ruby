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
      redirect_to user_path(id: params[:user_id])
    else
      render action: :new
    end
  end
  
  # User submits GET request to /users/:user_id/profile/edit
  def edit 
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  # User submits PUT/PATCH request to /users/:user_id/profile
  def update
    # Retrieve user's profile from database
    @user = User.find(params[:user_id])
    @profile = @user.profile
    # Mass Assign edited profile attributes
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      # Show success message and redirect to profile
      redirect_to user_path(id: params[:user_id])
    else
      render action: :edit
    end
  end
  
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
end