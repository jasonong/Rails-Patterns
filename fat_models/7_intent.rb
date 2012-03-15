# Fat models also means watching out
# for fat methods.

# The above feels fat and better broken down
# into appropriate scopes
# Another benefit of using scopes is
# displaying clearer intent

def similar_users
  User.exclude(self)
      .has_voted_at_least_a_product
      .in_same_cluster_as(self)
      .not_following(following)
end

# Imagine the following

def after_milestone_completion
  award_user_badges
  cheer_user_on
end

def award_user_badges
  award_bronze_medal if has_completed_a?
  award_silver_medal if has_completed_b?
  award_gold_medal   if has_completed_c?
end

def cheer_user_on
  notify_completed_a if has_completed_a?
  notify_completed_b if has_completed_b?
  notify_completed_c if has_completed_c?
end

# I know what the nested methods does
# even before reading it's actual code
