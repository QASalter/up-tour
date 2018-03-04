class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :amount_paid
      t.string :amount_left

      t.timestamps
    end
  end
end
