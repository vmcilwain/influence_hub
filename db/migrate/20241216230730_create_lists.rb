class CreateLists < ActiveRecord::Migration[8.0]
  def change
    create_table :lists do |t|
      t.string :name, null: false, default: ''
      t.string :title, null: false, default: ''
      t.string :val, null: false, default: ''
      t.boolean :enabled, default: true

      t.timestamps
    end

    add_index :lists, [:name, :title], unique: true
    add_index :lists, [:title, :val], unique: true
    add_index :lists, [:name, :title, :val], unique: true
  end
end
