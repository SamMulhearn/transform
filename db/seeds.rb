# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = User.create!(first_name:'Sam',last_name:'Mulhearn',email:'sam.Mulhearn@tribalgroup.com',password:'admin')
#admin = User.first
adminrole = admin.roles.create!(approvalgroup: false,name:'Administrator')
change_mgr = Role.create!(name: 'Change Manager',mandatory_appr:'t',approvalgroup:'t')
server_tech =Role.create!(name: 'Server Techinical Review',approvalgroup:'t')
20.times do
  User.create(:email => Faker::Internet.email, :first_name => Faker::Name.first_name,:last_name => Faker::Name.last_name,  :password => "passw0rd")
end


#admin.roles << adminrole = Role.create!(approvalgroup: false,name:'Admin',description:'Administrator')