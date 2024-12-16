class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.references :campaign, null: false, foreign_key: true 
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, default: ''
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
