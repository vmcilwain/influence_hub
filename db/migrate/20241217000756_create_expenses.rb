class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.string :name, null: false, default: ''
      t.string :category, null: false, default: ''
      t.decimal :amount, precision: 10, scale: 2, null: false, default: 0.00
      t.boolean :billable, default: false, null: false
      t.date :purchased_on
      t.references :campaign, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end

    add_index :expenses, :purchased_on
    add_index :expenses, :billable
  end
end
