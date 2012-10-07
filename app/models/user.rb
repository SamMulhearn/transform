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

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :role_ids
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }, :uniqueness => true
  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments, :uniq => true
  accepts_nested_attributes_for :roles
  accepts_nested_attributes_for :assignments
  before_save :create_remember_token
  has_many :rfcs

  	def fullname
		"#{self.first_name} #{self.last_name}"
	end
  
  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
