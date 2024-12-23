class AddColumnsToSignatures < ActiveRecord::Migration[8.0]
  def change
    add_column :signatures, :security_code, :string, null: false, default: ''
    add_column :signatures, :external_id, :string, null: false, default: ''
    add_column :signatures, :signee_email, :string, null: false, default: ''
    add_column :signatures, :signature, :string
    add_column :signatures, :signee_signature, :string
    add_column :signatures, :status, :integer, null: false, default: 0
    add_column :signatures, :signed_at, :datetime

    add_index :signatures, :external_id, unique: true
    add_index :signatures, :security_code, unique: true
    add_index :signatures, :signee_email
  end
end
