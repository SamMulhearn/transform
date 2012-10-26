module RfcsHelper
	def get_valid_statuses(rfc)
		if signed_in?
			if can? :destroy, rfc
				["New","Seek Approval","Approved","On Hold"]
			else
				["New","Seek Approval","On Hold","Closed"]
			end
		end
	end

	def rfc_link (rfc_id)
		link_to "RFC #{rfc_id}",rfc_path(rfc_id)
	end
	
	def get_rfcs_to_approve_count
		if signed_in?
			Approval.where(:closed => 'false', :role_id => current_user.role_ids).select {| a | a.rfc.status == "Seek Approval"}.collect(&:rfc_id).uniq.count
		else
			return 0
		end
	end

end
