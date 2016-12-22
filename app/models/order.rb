class Order < ActiveRecord::Base
  def self.delete_closed_order
    Order.where(status:'shipped').destroy_all
  end
end
