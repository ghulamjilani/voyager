class CreateTeamUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :team_users do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :team, null: false, foreign_key: true, index: true

      t.timestamps
    end
    add_index :team_users, [:user_id, :team_id], unique: true
  end
end
