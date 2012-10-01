# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string(255)
#  description   :string(255)
#  approvalgroup :boolean
#

class Role < ActiveRecord::Base
  attr_accessible :name, :description, :approvalgroup
  has_many :assignments
  has_many :users, :through => :assignments, :uniq => true

end
