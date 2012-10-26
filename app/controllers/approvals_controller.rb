class ApprovalsController < ApplicationController
	load_and_authorize_resource 
	
	def new
	end
	def create
	end
	def index
		#@rfcs = Rfc.where(:status => "Seek Approval").select {| r | (r.role_ids & current_user.role_ids).any? }
		@approvals = Approval.where(:closed => 'false', :role_id => current_user.role_ids).select {| a | a.rfc.status == "Seek Approval"}
		@rfcs =Rfc.find( (@approvals.collect(&:rfc_id).uniq),	:order => "imp_date DESC")
		if @rfcs.count == 0
			flash[:notice] = "You don't have any RFC's to review"
			redirect_to root_path
		end
	end
	def update
		@approval = Approval.find(params[:id]) #Not required because @user is defined in correct_user
    if @approval.update_attributes(params[:approval])
      #flash[:notice] = "Approval #{@approval.approved ? "approved" : "rejected"} on behalf of #{@approval.role.name} for #{link_to "RFC  @approval.rfc_id", @approval.rfc}"
      flash[:notice] = %Q[RFC #{@approval.rfc.id} #{@approval.approved ? "approved" : "rejected"} on behalf of #{@approval.role.name}]

      @approval.rfc.comments.create(comment: "RFC #{@approval.approved ? "approved" : "rejected"} on behalf of #{@approval.role.name}", :user => current_user, css_class: "#{@approval.approved ? 'success' : 'error'}")
	  	if @approval.rfc.approvals.where(:closed => 'false', :role_id => current_user.role_ids).select {| a | a.rfc.status == "Seek Approval"}.count > 0
	  		redirect_to rfc_path(@approval.rfc)
	  	else
	  		redirect_to approvals_path
	  	end

    else
      flash[:error] = "Failed to update approval on behalf of #{@approval.role.name} for RFC #{@approval.rfc_id}"
      redirect_to approvals_path
    end
  end
end
