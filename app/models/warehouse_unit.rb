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
    skus=skus.gsub("\r", '')
    unit=WarehouseUnit.find_by(name: box)
    unless unit.sku.nil? || unit.sku==''
      unit.update(sku: unit.sku+"\n"+skus)
    else
      unit.update(sku: skus)
    end
    unit.update(count: unit.sku.split("\n").count)
    unit.sku.gsub("\r", '')
    return skus.split("\n").join('|')+'are checked in'
  end

  def self.rescan(box, skus)
    skus=skus.gsub("\r", '')
    unit=WarehouseUnit.find_by(name: box)
    unit.update(sku: skus)
    unit.update(count: unit.sku.split("\n").count)
    return skus +'are rescan to'+box
  end

  def self.takeout(box, skus)
    skus=skus.gsub("\r", '')
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
          if unit.sku.nil?||unit.sku==''
            unit.update(sku: key)
          else
            unit.update(sku: unit.sku+"\n"+key)
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
      if !(box.sku.nil?||box.sku=='')
        box.update(sku: box.sku.gsub("\r", ''))
        box.update(sku: box.sku.gsub("\n\n", '\n'))
      end
    end
  end

  def self.get_warehouse_map
    map=Hash.new do |k, v|
      k[v]=Hash.new
    end
    WarehouseUnit.where(status: 'active').each do |u|
      qty_hash=Hash.new(0)
      u.sku.split("\n").each do |sku|
        qty_hash[sku]=qty_hash[sku]+1
      end
      map[u.name]=qty_hash
    end
    return map
  end

  def self.print_picklist(skus)
    file_name="/tmp/ pick_up_list_#{Date.today}.csv"
    CSV.open(file_name, 'w+b') do |f|
      f<<["Order Number","Location", "Sku", "Quantity"]
      map=WarehouseUnit.get_warehouse_map
      skus.each do |i|
        sku=i[0]
        order_number=i[1]
        map.each do |k, v|
          if v.key?(sku)
            if v[sku]>=1
              v[sku]=v[sku]-1
              f<<[order_number,k, sku, 1]
              break
            end
          end
        end
      end
    end
    return file_name
  end


end
