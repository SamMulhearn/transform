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

require 'spec_helper'

describe Role do
  it {should respond_to(:users)}
  it {should respond_to(:assignments)}
  it { should have_many(:users) }
end
