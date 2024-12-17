class CreateListItems < ActiveRecord::Migration[8.0]
  def change
    create_table :list_items do |t|
      t.references :list, null: false, foreign_key: true
      t.string :name, null: false, default: ''
      t.string :val, null: false, default: ''
      t.boolean :enabled, null: false, default: true

      t.timestamps
    end
  end
end
