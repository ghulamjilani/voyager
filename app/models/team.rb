class Team < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
end
