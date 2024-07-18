class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owned_teams, class_name: 'Team', foreign_key: 'owner_id'
  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users

  has_one_attached :avatar

  validates :first_name, :last_name, presence: true
  validates :user_name, presence: true, uniqueness: true,
            format: { with: /\A[\w]+\z/, message: 'only allows alphanumeric characters' }

  # after_create :assign_role

  scope :all_users, -> { joins(:roles).where(roles: { name: 'end_user' }).order(created_at: :desc) }

  def admin?
    has_role? :admin
  end

  def end_user?
    has_role? :end_user
  end

  def current_team
    teams.where(id: current_team_id)&.last
  end

  def assign_role
    add_role(:end_user, self)
  end

  def current_role
    roles&.last&.name || 'end_user'
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def avatar_url
    Rails.application.routes.url_helpers.url_for(avatar) if avatar.attached?
  end
end
