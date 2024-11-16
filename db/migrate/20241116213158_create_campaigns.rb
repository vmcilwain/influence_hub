class CreateCampaigns < ActiveRecord::Migration[8.0]
  def change
    create_table :campaigns do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, default: ''
      t.string :description
      t.integer :status, null: false, default: 0
      t.decimal :rate, precision: 10, scale: 2
      t.decimal :engagement_rate, precision: 10, scale: 2
      t.decimal :reach, precision: 10, scale: 2
      t.decimal :clicks, precision: 10, scale: 2

      t.timestamps
    end
  end
end
