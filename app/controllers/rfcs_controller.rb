class RfcsController < ApplicationController

  load_and_authorize_resource 

  helper_method :sort_column, :sort_direction

	def new
    if signed_in?
      @rfc = current_user.rfcs.build
    else
      redirect_to root_path, notice: "Sorry, you need to be logged in to create an RFC"
    end
	end

	def index
    #Rfc.order(params[:sort])
		#@rfcs = Rfc.paginate(:page => params[:page], :per_page => 10,:order => (sort_column + ' ' + sort_direction)) # 'imp_date ASC')
    @search = Rfc.search(params[:q])
    @search.sorts = (sort_column + ' ' + sort_direction)
    @rfcs = @search.result.paginate(:page => params[:page], :per_page => 10) #,:order => (sort_column + ' ' + sort_direction))
	end

  def destroy
    Rfc.find(params[:id]).destroy
    flash[:notice] = ("RFC deleted")
    redirect_to rfcs_path
  end

  def show
    @rfc = Rfc.find(params[:id])
    if signed_in?
      @approvals = @rfc.approvals.where(:closed => 'false', :role_id => current_user.role_ids).select {| a | a.rfc.status == "Seek Approval"}
    end
  end

	def create
    	@rfc = Rfc.new(params[:rfc])
    	if @rfc.save
      		redirect_to edit_rfc_path(@rfc), notice: "RFC #{@rfc.id} saved."
    	else
      		render 'edit'
    	end
	end

 	def update
    @rfc = Rfc.find(params[:id])
    if @rfc.update_attributes(params[:rfc])
      flash[:notice] = "RFC#{@rfc.id} updated"
      redirect_to edit_rfc_path(@rfc)
    else
      flash[:error] = "Failed to update RFC#{@rfc.id}"
      redirect_to edit_rfc_path(@rfc)
    end
  end

  def cs
    respond_to do |format|
      format.html
      format.json { 
        if (params[:start]).present? and (params[:end]).present? then
          @rfcs = Rfc.scheduled_between(Time.at(params['start'].to_i),Time.at(params['end'].to_i)).where("rfcs.imp_date IS NOT NULL")          
        else
          @rfcs = Rfc.where("rfcs.imp_date IS NOT NULL")
        end
      }
    end
  end

  def edit
    @rfc = Rfc.find(params[:id])
  end

  private
    def sort_column
      Rfc.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
    end
end
