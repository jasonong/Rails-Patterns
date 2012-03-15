# Group related methods into a mixin

class User < ActiveRecord::Base
  has_one :milestone

  delegate :has_completed_a,
           :has_completed_b,
           :has_completed_c,
           :to => :milestone,
           :allow_nil => true

  include UserAchievables
end

# app/lib/user_achievables.rb
module UserAchievable
  Milestone.MILESTONES.each do |name|
    define_method "had_#{name}" do
      m = Milestone.find_or_create_by_user_id(self.id)
      m.send("has_#{name}=", true)
      m.save
      self.reload
    end
  end
end

# config/application.rb
config.autoload_paths += %W(#{config.root}/app/lib)

class Milestone < ActiveRecord::Base
  has_many :users

  MILESTONES = %w{ completed_a completed_b completed_c }

# Attributes
# has_completed_a :boolean
# has_completed_b :boolean
# has_completed_c :boolean
end
