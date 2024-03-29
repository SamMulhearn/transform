class SessionsController < ApplicationController
  def new
  end

  def create
    #user = User.find_by_email(params[:session][:email #Use if FORM_FOR
    #if user && user.authenticate(params[:session][:password])
    user = User.find_by_email(params[:email].downcase) #Use if FORM_TAG
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_back_or root_path
      #redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end