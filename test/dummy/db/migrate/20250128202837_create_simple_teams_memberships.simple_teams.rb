# This migration comes from simple_teams (originally 20240311053006)
class CreateSimpleTeamsMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :simple_teams_memberships do |t|
      t.references :team, null: false, foreign_key: { to_table: :simple_teams_teams }
      t.references :member, null: false, foreign_key: { to_table: :users }
      t.integer :role, null: false, default: 0

      t.timestamps
    end
  end
end
