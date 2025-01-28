# This migration comes from simple_teams (originally 20240311052758)
class CreateSimpleTeamsTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :simple_teams_teams do |t|
      t.references :teamable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
