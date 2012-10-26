json.array!(@rfcs) do |rfc|
	json.id rfc.id
	if !rfc.user.nil?
		json.title "#{rfc.id}: #{rfc.title} [#{rfc.user.first_name}]"
	else
		json.title "#{rfc.id}: #{rfc.title}"
	end if
	json.allDay true
	json.start rfc.imp_date
	json.url rfc_path(rfc)

	if rfc.downtime?
		json.className = "cal-downtime"
	end
	case "#{rfc.status}"
		when "New" then
			json.backgroundColor "#B3B3B3" 
		when "Seek Approval" then
			json.backgroundColor "#6691ED"
		when "Approved" then
			json.backgroundColor "#66ED88"
		when "On Hold" then
			json.backgroundColor "#B3B3B3"
		when "Closed" then
			json.backgroundColor "#B3B3B3"
	end
end