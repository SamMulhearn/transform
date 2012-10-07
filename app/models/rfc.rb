class Rfc < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  #1 = Emergency, 2=Standard, 3=Low, 4=Retrospective
  validates_inclusion_of :priority, :in => [1, 2, 3, 4], :allow_nil => true
  
end
