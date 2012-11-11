# The class below highlights a coupling of parameters between methods

class ProductSearch < ActiveRecord::Base

  def between(start_date, end_date)
    Product.created_between(start_date, end_date)
  end

end

class Product

  def self.created_between(start_date, end_date)
    where("created_at >= ? AND created_at < ?", start_date, end_date)
  end

end

# We can improve by making parameters into it's own object

class DateRange < Struct.new(:start_date, :end_date)
end

class ProductSearch < ActiveRecord::Base

  def between(date_range)
    Product.created_between(date_range)
  end

end

class Product

  def created_between(date_range)
    start_date = date_range.start_date
    end_date = date_range.end_date
    where("created_at >= ? AND created_at < ?", start_date, end_date)
  end

end

# Then we can call products like this

ProductSearch.between(DateRange.new('2012-11-10', '2012-11-11')

