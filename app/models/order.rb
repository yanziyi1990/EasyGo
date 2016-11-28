class Order < ActiveRecord::Base
  def self.delete_closed_order
    Order.where(status:'Shipped').destroy_all
  end

  def self.print_pick_list
    unprocess_order=Order.where(status:'unprocessed')
    location_hash=Hash.new([])
  end

end
