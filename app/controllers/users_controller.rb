class UsersController < ApplicationController
	load_and_authorize_resource
  
  def index
		@users = User.paginate(:page => params[:page], :per_page => 12,)
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

  def edit
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    fn = @user.fullname
    if @user.destroy
      flash[:notice] = ("Deleted #{fn}'s user account")
      redirect_to users_path
    else
      flash[:notice] = ("Failed to delete #{fn}'s user account")
    end
  end

  	def update
    @user = User.find(params[:id]) #Not required because @user is defined in correct_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Updated #{@user.fullname}'s account"
      redirect_to @user
    else
      render 'edit'
    end
  end


	def create
    	@user = User.new(params[:user])
    	if @user.save
          sign_in @user
      		redirect_to @user, notice: "Thanks for signing up."
    	else
      		render 'new'
    	end
	end
end
