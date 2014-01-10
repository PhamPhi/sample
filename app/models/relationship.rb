class Relationship < ActiveRecord::Base
  # Adding the relationship from this model and user model...
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # Adding the validation for fields...
  validates :followed_id, presence: true
  validates :follower_id, presence: true
end
