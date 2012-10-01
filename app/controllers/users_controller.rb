class UsersController < ApplicationController
	def index
		@users = User.paginate(:page => params[:page], :per_page => 5,)
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def destroy
		email = User.find(params[:id]).email
	    User.find(params[:id]).destroy
	    flash[:notice] = (" User deleted. (" + email + ")")
	    redirect_to users_path
  	end

  	def update
    @user = User.find(params[:id]) #Not required because @user is defined in correct_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated"
      #sign_in @user
      redirect_to @user
    else
      render 'show'
    end
  end


	def create
    	@user = User.new(params[:user])
    	if @user.save
      		redirect_to @user, notice: "Thanks for signing up."
    	else
      		render 'new'
    	end
	end
end
