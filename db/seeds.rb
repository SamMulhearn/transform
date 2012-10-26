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
change_mgr = Role.create!(name: 'Change Management',mandatory_appr:'t',approvalgroup:'t')
server_tech =Role.create!(name: 'Server Techinical Review',approvalgroup:'t')

20.times do
  User.create(:email => Faker::Internet.email, :first_name => Faker::Name.first_name,:last_name => Faker::Name.last_name,  :password => "passw0rd")
end

def lorem_s
	return Faker::Lorem.sentence
end
def lorem_p
	return Faker::Lorem.paragraph
end

50.times do
	xdate = rand(1.years).ago
	xstart = xdate + 1.hours
	xend = xdate + 2.hours
	xuser = User.offset(rand(User.count)).first
	xdowntime = [true, false].sample
	x = Rfc.create!(title:lorem_s, imp_date:xdate, user:xuser, status:"New", imp_plan:lorem_p, pre_task:lorem_p, post_task:lorem_p, 
	backup:lorem_p, impact:lorem_p, objective:lorem_p, risk:lorem_p, mitigate_risks:lorem_p, downtime:xdowntime, 
	downtime_start:xstart, downtime_finish:xend)
	(rand(0..3)to_i).times do
		Comment.create!(:user => User.offset(rand(User.count)).first, :rfc => x, :comment => lorem_p)
	end
end

#admin.roles << adminrole = Role.create!(approvalgroup: false,name:'Admin',description:'Administrator')