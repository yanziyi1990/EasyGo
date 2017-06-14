class Group < ActiveRecord::Base
  has_many :users, through: :group_members
  has_many :group_members
  has_many :permissions
  has_many :resources, through: :permissions
end
