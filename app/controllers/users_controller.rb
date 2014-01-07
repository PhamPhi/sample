class UsersController < ApplicationController


  def create
    @user = User.new(user_params)
    if @user.save
      # Handle the successful creation
      flash[:success] = "Welcome to the Techie Blog! Application"
      redirect_to @user
    else
      #redirect the new page
      render 'new'
    end
  end
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
