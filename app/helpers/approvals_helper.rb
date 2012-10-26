module ApprovalsHelper
	def rfc_link (rfc_id)
		link_to "RFC #{rfc_id}",rfc_path(rfc_id)
	end
end
