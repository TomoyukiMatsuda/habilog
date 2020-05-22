class CreateBadLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :bad_logs do |t|
      t.integer :log
      t.references :bad_habit, foreign_key: true

      t.timestamps
    end
  end
end
