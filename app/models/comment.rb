class Comment < ActiveRecord::Base
  attr_accessible :comment, :rfc_id, :user_id, :user, :rfc, :css_class
  belongs_to :rfc
  belongs_to :user
  validates_presence_of :user_id, :rfc_id
end
