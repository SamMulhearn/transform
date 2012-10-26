class Approval < ActiveRecord::Base
  attr_accessible :closed, :rfc_id, :role_id, :closed, :approved, :active
  belongs_to :rfc
  belongs_to :role
  after_save :update_rfc

  def update_rfc
		#Approve RFC if all approvals are closed
  	if self.rfc.approvals.where(:closed => true).count == self.rfc.approvals.count then #if all are closed
			if (self.rfc.approvals.where(:approved => true).count == self.rfc.approvals.count) then #all are approved
				self.rfc.update_attributes(:status => "Approved")
			end
  	end
  	#On Hold RFC is an approval is rejected.
  	if self.approved == false and self.closed == true then
  		self.rfc.update_attributes(:status => "On Hold")
  	end
  end

end


