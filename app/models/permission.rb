class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :resource
end
