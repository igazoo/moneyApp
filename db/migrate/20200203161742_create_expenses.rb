class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :category
      t.integer :money
      t.string :month
      t.string :date
      t.timestamps
    end
  end
end
