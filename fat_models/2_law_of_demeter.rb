class User < ActiveRecord::Base
  has_one :milestone

# The following is brittle coz
# has_completed_a can blow up
# if user.milestone is nil
#
# user.milestone.has_completed_a
#
# This is slightly better
#
# user.milestone.try(:has_completed_a)
#
# Reduce the number of dots by
# adding it as User's instance method
#
# user.has_completed_a
#
# Bonus: makes the user milestone
# testable and stub friendly

  def has_completed_a
    milestone.try(:has_completed_a)
  end

  def has_completed_b
    milestone.try(:has_completed_b)
  end

  def has_completed_c
    milestone.try(:has_completed_c)
  end
end

class Milestone < ActiveRecord::Base
  has_many :users

# Attributes
# has_completed_a :boolean
# has_completed_b :boolean
# has_completed_c :boolean
end
