class UsersController < ApplicationController

  # Notify to the controller just only 2 method update, edit.
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  def create
    @user = User.new(user_params)
    if @user.save
      # Handle the successful creation
      sign_in @user
      flash[:success] = "Welcome to the Techie Blog! Application"
      redirect_to @user
    else
      #redirect the new page
      render 'new'
    end
  end

  # Constructor method, It's used to create the new User object...
  #
  def new
    @user = User.new
  end
  #
  #Method edit. It used to edit the user profile
  #
  def edit
   @user = User.find(params[:id])
  end

  #
  # Method update. It's used to update the user's profile
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      # Rendering to the edit method...
      render 'edit'
    end
  end
  #
  #Method show. It used to show the user
  #
  def show
    @user = User.find(params[:id])
  end

  #
  #Method destroy. It used to destroy the user signin
  #@param none
  #
  def destroy
    sign_out
    redirect_to root_url
  end

=begin
  unless signed_in?
    flash[:notice] = "Please sign in"
    redirect_to signin_url
  end
=end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
