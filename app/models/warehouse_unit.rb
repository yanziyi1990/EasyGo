class WarehouseUnit < ActiveRecord::Base
  def self.warehouse_oprate(action, box, skus)
    case action
      when 'checkin'
        return self.checkin(box, skus)
      when 'rescan'
        return self.rescan(box, skus)
      when 'takeout'
        return self.takeout(box, skus)
    end
  end

  def self.checkin(box, skus)
    unit=WarehouseUnit.find_by(name: box)
    unless unit.sku.nil? || unit.sku=''
      unit.update(sku: unit.sku+"\n"+skus)
    else
      unit.update(sku: skus)
    end
    unit.update(count: unit.sku.split("\n").count)
    unit.sku.gsub("\r", '')
    return skus.split("\n").join('|')+'are checked in'
  end

  def self.rescan(box, skus)
    unit=WarehouseUnit.find_by(name: box)
    unit.update(sku: skus)
    unit.update(count: unit.sku.split("\n").count)
    return skus +'are rescan to'+box
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
    unit.update(sku: nil)
    warehouse_hash.keys.each do |key|
      if warehouse_hash[key]>0
        warehouse_hash[key].times do
          if unit.sku.nil?
            unit.sku.update(sku: key)
          else
            unit.sku.update(sku: unit.sku+"\n"+key)
          end
        end
      end
    end
    if unit.sku.nil?
      unit.update(count: 0)
    else
      unit.update(count: unit.sku.split("\n").count)
    end
    return error_hash
  end

  def self.clean_dash_r
    WarehouseUnit.all.each do |box|
      if !box.sku.nil?
        box.update(sku: box.sku.gsub("\r", ''))
        box.update(sku: box.sku.gsub("\n\n", '\n'))
      end
    end
  end

end
