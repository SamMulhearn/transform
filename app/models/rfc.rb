# == Schema Information
#
# Table name: rfcs
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  priority        :integer
#  title           :string(255)
#  status          :text
#  objective       :string(255)
#  risk            :text
#  mitigate_risks  :text
#  backup          :text
#  impact          :text
#  imp_plan        :text
#  pre_task        :text
#  post_task       :text
#  backout_plan    :text
#  start           :datetime
#  finish          :datetime
#  downtime_start  :datetime
#  downtime_finish :datetime
#



class Rfc < ActiveRecord::Base
  attr_accessible :priority, :title, :status, :objective, :risk, :mitigate_risks, :backup, :impact, :imp_plan, :pre_task, :post_task, :backout_plan, :imp_date, :downtime_start, :downtime_finish, :user_id, :user

  belongs_to :user
  #1 = Emergency, 2=Standard, 3=Low, 4=Retrospective
  validates_inclusion_of :priority, :in => [1, 2, 3, 4], :allow_nil => true
  validates_inclusion_of :status, :in => ['New', 'Seek Approval','Approved', 'On Hold'], :allow_nil => false
end
