# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#
# Indexes
#
#  index_users_on_remember_token  (remember_token)
#

require 'spec_helper'

describe User do
  it {should respond_to(:first_name)}
  it {should respond_to(:last_name)}
  it {should respond_to(:email)}
  it {should respond_to(:password)}
  it {should respond_to(:authenticate)}
  it {should respond_to(:roles)}
  it {should respond_to(:assignments)}
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }
  it { should_not allow_mass_assignment_of(:password_digest)}
  it { should_not allow_mass_assignment_of(:id) }
  it {should have_many(:roles)}



  it "user with valid email should be valid" do
    ['sam.mulhearn@domain.com','p1@p1.com','X@beter.com','user@sub.domain.com','spoon@fork.com'].each do |x|
      user = FactoryGirl.build(:user,email:x)
      user.should be_valid
    end
  end


  it "with invalid emails should not be valid" do
    ['hhhhh11~!','','1@1.1','elej@','@@','samuel@hotmail!.com','.@.',''].each do |x|
      user = FactoryGirl.build(:user, email:x)
      user.should_not be_valid
    end
  end

end

