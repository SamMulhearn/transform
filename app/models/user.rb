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
  attr_accessor :assignto #Used in delete action
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }, :uniqueness => true
  has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments, :uniq => true
  before_save :create_remember_token , :downcase_email
  has_many :rfcs
  has_many :comments

  	def fullname
		"#{self.first_name} #{self.last_name}"
	end
  
  private
    def downcase_email
      self.email = self.email.downcase
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def current_approvals
      Rfc.where(:status => "Seek Approval").approvals.where(:role => self.roles).select(:rfc_id).uniq.count
    end
end
