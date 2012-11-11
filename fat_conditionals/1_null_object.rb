# The class below highlights conditionals to respond if object is nil

class User < ActiveRecord::Base

  has_one :address

  def full_address
    if address
      address.full
    else
      'None'
    end
  end

end

# Now we'll create a NullAddress class which will get instantiated if
# user object has no associated address

class NullAddress

  def full
    'None'
  end

end

class User < ActiveRecord::Base

  has_one :address

  def initialize
    @address = address || NullAddress.new
  end

  def full_address
    @address.full
  end

end

