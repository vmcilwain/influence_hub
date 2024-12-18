class CreateAppDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :app_documents do |t|
      t.string :name, null: false, default: ""
      t.string :description
      t.integer :status, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
