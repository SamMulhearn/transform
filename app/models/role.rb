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

class Role < ActiveRecord::Base
  attr_accessible :name, :approvalgroup, :mandatory_appr, :user_ids
  has_many :assignments, :dependent => :destroy
  has_many :users, :through => :assignments, :uniq => true
  
  has_many :approvals, :dependent => :destroy
  has_many :rfcs, :through => :approvals, :uniq => true
  
#  before_validation :set_booleans
  validates :mandatory_appr, :inclusion => {:in => [true, false]}
  validates :approvalgroup, :inclusion => {:in => [true, false]}
  validates :name, :presence => true, :uniqueness => true

  def mandatory?
		self.mandatory_appr? ? "Yes" : "No"
 		#self.mandatory_appr? ? "1" : "0"
	end

	private
		def set_booleans
			self.mandatory_appr = false if self.mandatory_appr? == false #Don't allow nil
			self.approvalgroup = false if self.approvalgroup? == false #Don't allow nil
      self.mandatory_appr = false if self.approvalgroup == false #If it's not an approval group, then it can't be mandatory approval
		  return true #continue
    end
end

