module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    #link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    js = "
		$('#f_column').val('#{column}').trigger('change');
		$('#f_direction').val('#{direction}').trigger('change');
		$('#rfc_search').submit();
		"
    link_to_function title, js, :class => css_class
  end
end