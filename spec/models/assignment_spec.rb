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

require 'spec_helper'

describe Assignment do
	it {should respond_to(:roles)}
	it {should respond_to(:users)}
end
