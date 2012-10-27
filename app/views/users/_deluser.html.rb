form
select_tag "Re-Assign RFC's to", options_from_collection_for_select(User.all, "id", "fullname")