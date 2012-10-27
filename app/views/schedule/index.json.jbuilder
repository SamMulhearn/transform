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
		json.className "cal-downtime"
		json.borderColor "red"
	end
	case "#{rfc.status}"
		when "New" then
			json.backgroundColor "#81E9F7" #Light Blue
		when "Seek Approval" then
			json.backgroundColor "#FFB259" #Orange
		when "On Hold" then
			json.backgroundColor "#CF5555" #Light red
		when "Approved" then
			json.backgroundColor "#69FF7F" #Green
		when "Closed" then
			json.backgroundColor "#CCBFD6" #Grey
	end
end