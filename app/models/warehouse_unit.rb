class WarehouseUnit < ActiveRecord::Base
  def self.checkin(box, skus)
    unit=WarehouseUnit.find_by(name: box)
    unless unit.sku.nil?
      unit.update(sku: unit.sku+skus)
    else
      unit.update(sku: skus)
    end
    unit.update(count: unit.sku.split("\n").count)
    return skus
  end

  def self.rescan(box, skus)
    unit=WarehouseUnit.find_by(name: box)
    unit.update(sku: skus)
    unit.update(count: unit.sku.split("\n").count)
    return skus
  end

  def self.checkout(box, skus)
    unit=WarehouseUnit.find_by(name: box)
    checkout_list=skus.split("\n")
    current_list=unit.sku.split("\n")
    # to do list
    checkout_hash=Hash.new(0)
    checkout_list.each do |item|
      checkout_hash[item]=checkout_hash[item]+1
    end

    # base list
    warehouse_hash=Hash.new(0)
    current_list.each do |item|
      warehouse_hash[item]=warehouse_hash[item]+1
    end

    checkout_hash


    unit.update(count: unit.sku.split("\n").count)
  end


end
