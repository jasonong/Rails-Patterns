class User < ActiveRecord::Base
  has_one :milestone

  delegate :has_completed_a,
           :has_completed_b,
           :has_completed_c,
           :to => :milestone,
           :allow_nil => true

# Following the law of demeter,
# this might be a bad idea
#
# milestone = user.milestone
# milestone.has_completed_a = true
# milestone.save
#
# You could delegate this to a
# User's instance method
#
# def had_completed_a
#  ...
# end
#
# That's fine but can get messy quickly
# DRY it up with a little metaprogramming

  Milestone.MILESTONES.each do |name|
    define_method "had_#{name}" do
      m = Milestone.find_or_create_by_user_id(self.id)
      m.send("has_#{name}=", true)
      m.save
      self.reload
    end
  end
end

class Milestone < ActiveRecord::Base
  has_many :users

  MILESTONES = %w{ has_completed_a has_completed_b has_completed_c }

# Attributes
# has_completed_a :boolean
# has_completed_b :boolean
# has_completed_c :boolean
end
