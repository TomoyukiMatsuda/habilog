class CreateGoodLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :good_logs do |t|
      t.integer :log
      t.references :good_habit, foreign_key: true

      t.timestamps
    end
  end
end
