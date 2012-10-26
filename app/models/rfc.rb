# == Schema Information
#
# Table name: rfcs
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  priority        :integer
#  title           :string(255)
#  status          :text
#  objective       :text
#  risk            :text
#  mitigate_risks  :text
#  backup          :text
#  impact          :text
#  imp_plan        :text
#  pre_task        :text
#  post_task       :text
#  backout_plan    :text
#  imp_date        :date
#  downtime_start  :time
#  downtime_finish :time


class Rfc < ActiveRecord::Base
  attr_accessible :priority, :title, :status, :objective, :risk, :mitigate_risks, :backup, :impact, :imp_plan, :pre_task, 
  	:post_task, :backout_plan, :imp_date, :downtime_start, :downtime_finish, :user_id, :user, :downtime, :role_ids

	belongs_to :user
	has_many :approvals, :dependent => :destroy
	has_many :roles, :through => :approvals, :uniq => true
	has_many :comments, :dependent => :destroy

	accepts_nested_attributes_for :user, :approvals, :roles, :comments

	scope :scheduled_between, lambda {|start_date, end_date| where("imp_date >= ? AND imp_date <= ?", start_date, end_date )}


  #1 = Emergency, 2=Standard, 3=Low, 4=Retrospective
  
  validates_inclusion_of :priority, :in => [1, 2, 3, 4], :allow_nil => true
  validates_inclusion_of :status, :in => ['New', 'Seek Approval','Approved', 'On Hold','Closed'], :allow_nil => false
  validates_presence_of :downtime_start, :if => :downtime?
	validates_presence_of :downtime_finish, :if => :downtime?

	after_save :validatedowntime, :create_mandatory_approvals, :reset_approvals


	def imp_date_in_words
		return self.imp_date.strftime("%A, #{self.imp_date.day.ordinalize} %B %Y") if !self.imp_date.nil?
	end

	private
		def validatedowntime
			if !self.downtime? #clear times if downtime false
				self.downtime_start = nil
				self.downtime_finish = nil
			end
		end

		def create_mandatory_approvals
			mand_roles = Role.where(:approvalgroup => true, :mandatory_appr => true)
			mand_roles.each do |r|
				if !self.roles.include?(r)
					self.roles << r
				end
			end
		end

		def reset_approvals
      if self.status == "Seek Approval"
	    	self.approvals.update_all("closed = 'false', approved = 'false'")
	    end
	    if self.status == "Approved"
	    	self.approvals.update_all("closed = 'true', approved = 'true'")
	    end
	  end
end
