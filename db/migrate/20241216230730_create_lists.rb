class CreateLists < ActiveRecord::Migration[8.0]
  def change
    create_table :lists do |t|
      t.string :name, null: false, default: ''
      t.string :description
      t.boolean :enabled, default: true

      t.timestamps
    end

    add_index :lists, :name, unique: true
  end
end

# t.string :title, null: false, default: ''
# t.string :val, null: false, default: ''

# add_index :lists, [:title, :val], unique: true
# add_index :lists, [:name, :title, :val], unique: true