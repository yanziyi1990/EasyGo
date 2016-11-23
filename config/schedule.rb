every 1.hours do # 1.minute 1.day 1.week 1.month 1.year is also supported
  Order.refresh
end

every :day, :at => '12am' do # Use any day of the week or :weekend, :weekday
  Order.delete_closed_order
end
