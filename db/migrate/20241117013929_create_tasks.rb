class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :campaign, null: false, foreign_key: true
      t.string :description, null: false, default: ''
      t.integer :status, default: 0, null: false
      t.date :due_on
      t.integer :kind, default: 0, null: false

      t.timestamps
    end
  end
end
