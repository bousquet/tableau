class Album < ActiveRecord::Base
  
  belongs_to :user
  has_and_belongs_to_many :photos
  acts_as_list
  
  validates_presence_of :title
  
end
