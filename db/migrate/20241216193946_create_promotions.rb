class CreatePromotions < ActiveRecord::Migration[8.0]
  def change
    create_table :promotions do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.timestamps
    end
  end
end
