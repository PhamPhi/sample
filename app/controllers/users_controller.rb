class UsersController < ApplicationController


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

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
