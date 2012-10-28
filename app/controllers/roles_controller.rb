class RolesController < ApplicationController
	load_and_authorize_resource 
	def index
		@roles = Role.where(:approvalgroup => 't').paginate(:page => params[:page], :per_page => 10,)
	end

	def new
		@role = Role.new(:approvalgroup => 't')
	end

	def edit
		@role = Role.find(params[:id])
	end

	def destroy
		@role = Role.find(params[:id])
		rfc_ids = @role.rfc_ids
		if @role.destroy
	  	Rfc.find(rfc_ids).each do | r |
    		if r.status == "Seek Approval"
    			if r.approvals.count > 0
    				r.approvals.each do | a |
    					a.update_rfc # Check existing approvals, if all are approved then approved RFC
    				end
    			else
    				r.update_attributes(:status => "Approved") #The role deleted was the only approval, approved RFC
    			end
    		end
    	end
    	flash[:notice] = ("Deleted #{@role.name} group.")
    	redirect_to roles_path
    else
    	render 'edit'
    end
  end

	def update
    @role = Role.find(params[:id]) #Not required because @user is defined in correct_user
    if @role.update_attributes(params[:role])
      flash[:notice] = "Updated #{@role.name} group."
      redirect_to roles_path
    else
      render 'edit'
    end
  end


	def create
    	@role = Role.new(params[:role])
    	@role.approvalgroup = 't'
    	if @role.save
      		redirect_to roles_path, notice: "Created #{@role.name}."
    	else
      		render 'new'
    	end
	end

end
