class CreateClubs < ActiveRecord::Migration[5.1]
  def change
    create_table :clubs do |t|
      t.string  :name
      t.integer :amount
      t.integer :paid

      t.timestamps
    end
  end
end
