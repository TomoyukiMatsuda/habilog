class CreateGoodHabits < ActiveRecord::Migration[5.2]
  def change
    create_table :good_habits do |t|
      t.string :name
      t.references :goal, foreign_key: true

      t.timestamps
    end
  end
end
