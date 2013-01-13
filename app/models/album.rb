# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  created_at :datetime
#  position   :integer
#

class Album < ActiveRecord::Base
  
  belongs_to :user
  has_and_belongs_to_many :photos
  acts_as_list
  
  validates_presence_of :title
  
end
