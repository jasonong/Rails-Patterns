class User < ActiveRecord::Base
  has_one :milestone

# The User's instance method
# be delegated to Milestone so
# we don't have to define them

  delegate :has_completed_a,
           :has_completed_b,
           :has_completed_c,
           :to => :milestone,
           :allow_nil => true
end

class Milestone < ActiveRecord::Base
  has_many :users

# Attributes
# has_completed_a :boolean
# has_completed_b :boolean
# has_completed_c :boolean
end
