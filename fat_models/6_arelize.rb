# Fat models also means watching out
# for fat methods.

class User < ActiveRecord::Base
  def similar_users
    ids = following
    User.includes(:voted_products)
        .where(
           "users.id != ? AND
            users.cluster_id = ? AND
            users.identifier NOT IN (?) AND
            users.id = votes.voted_id",
            self.id, self.cluster_id, ids
         )
  end

  def following
    ...
  end
end

# The above feels fat and better broken down
# into appropriate scopes

class User < ActiveRecord::Base

  def similar_users
    User.exclude(self)
        .has_voted_at_least_a_product
        .in_same_cluster_as(self)
        .not_following(following)
  end

  scope :exclude, lambda { |user| where("users.id != ?", user.id) }
  scope :in_same_cluster_as, lambda { |user| where("users.cluster_id = ?", user.cluster_id) }
  scope :not_following, lambda { |ids| where("users.identifier NOT IN (?)", ids) }
  scope :has_voted_at_least_a_product, includes(:voted_products).where("users.id = votes.voter_id")

  def following
    ...
  end
end

# Even though this has resulted in more lines
# of code, it still worth it coz each scope
# is testable and reusable. The latter can
# result in less lines of code over time.
