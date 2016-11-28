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

  def self.takeout(box, skus)
    error_hash={}
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
    checkout_hash.keys.each do |key|
      if warehouse_hash.key?(key)
        if warehouse_hash[key]>=checkout_hash[key]
          warehouse_hash[key]=warehouse_hash[key]-checkout_hash[key]
        else
          error_hash[key]="Fail to check out #{checkout_hash[key]} #{key}, Doesn't have enough quantity"
        end
      else
        error_hash[key]="Fail to check out #{checkout_hash[key]} #{key}, Doesn't have this item in box #{box}"
      end
    end
    unit.update(sku:nil)
    warehouse_hash.keys.each do |key|
     if warehouse_hash[key]>0
       warehouse_hash[key].times do
         if unit.sku.nil?
           unit.sku.update(sku:key)
         else
           unit.sku.update(sku:unit.sku+"\n"+key)
         end
       end
     end
    end
    unit.update(count: unit.sku.split("\n").count)
  end


end
