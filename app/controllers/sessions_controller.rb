class SessionsController < ApplicationController

  def new

  end
  #
  # GET Method
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page...
      sign_in user
      redirect_to user
    else
      # Create an error message and re-render the sign-in form.
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end

  end
  #
  # DELETE Method
  def destroy

  end
end
