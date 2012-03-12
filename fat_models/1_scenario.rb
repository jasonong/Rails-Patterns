class User < ActiveRecord::Base
  has_one :milestone
end

class Milestone < ActiveRecord::Base
  has_many :users

# Attributes
# has_completed_a :boolean
# has_completed_b :boolean
# has_completed_c :boolean
end
