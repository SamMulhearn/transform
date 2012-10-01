# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_id    :integer
#  user_id    :integer
#

class Assignment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :role
  belongs_to :user
end
