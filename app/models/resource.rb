class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :permissions
  has_many :groups, through: :permissions
  has_many :users, through: :groups


  def check_permission(user)
    if self.user==user
      return true;
    elsif self.users.exists?(user)
      return true
    else
      return false
    end
  end


end
