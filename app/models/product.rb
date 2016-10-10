class Product < ActiveRecord::Base
  before_filter :authenticate_user!

end
