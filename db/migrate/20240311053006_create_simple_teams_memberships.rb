class CreateSimpleTeamsMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :simple_teams_memberships do |t|
      t.references :team, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
