class CreateSimpleTeamsInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :simple_teams_invitations do |t|
      t.references :team, null: false, foreign_key: true
      t.references :inviter, null: false, foreign_key: true
      t.references :membership, null: false, foreign_key: true
      t.string :email, null: false
      t.string :role, null: false, default: 0
      t.string :token, null: false
      t.integer :status, default: 0
      t.datetime :sent_at
      t.datetime :expires_at

      t.timestamps
    end
  end
end
