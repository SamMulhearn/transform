# == Schema Information
#
# Table name: roles
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  name           :string(255)
#  approvalgroup  :boolean
#  mandatory_appr :boolean
#

class Role < ActiveRecord::Base
  attr_accessible :name, :approvalgroup, :mandatory_appr
  has_many :assignments
  has_many :users, :through => :assignments, :uniq => true

  def mandatory?
 	self.mandatory_appr? ? "Yes" : "No"
end

end

