class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.integer :guest_id
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.boolean :approved

      t.timestamps
    end
  end
end
