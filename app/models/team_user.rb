class TeamUser < ApplicationRecord
  rolify

  belongs_to :team
  belongs_to :user

  def team_admin?
    has_role? :team_admin
  end

  def member?
    has_role? :member
  end
end
