class RfcsController < ApplicationController

  load_and_authorize_resource 
	def new
    if signed_in?
      @rfc = current_user.rfcs.build
    else
      redirect_to root_path, notice: "Sorry, you need to be logged in to create an RFC"
    end
	end

	def index
		@rfcs = Rfc.paginate(:page => params[:page], :per_page => 10,:order => 'imp_date ASC')
	end

	def create
    	@rfc = Rfc.new(params[:rfc])
    	if @rfc.save
      		redirect_to edit_rfc_path(@rfc), notice: "RFC#{@rfc.id} saved."
    	else
      		render 'edit'
    	end
	end


 	def update
    @rfc = Rfc.find(params[:id]) #Not required because @user is defined in correct_user
    if @rfc.update_attributes(params[:rfc])
      flash[:notice] = "RFC#{@rfc.id} updated"
      redirect_to edit_rfc_path(@rfc)
    else
      flash[:error] = "Failed to update RFC#{@rfc.id}"
      redirect_to edit_rfc_path(@rfc)
    end
  end


  def edit
    @rfc = Rfc.find(params[:id])
  end


end
