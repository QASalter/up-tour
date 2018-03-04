class CreateTimeChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :time_checks do |t|
      t.datetime :last_checked

      t.timestamps
    end
  end
end
