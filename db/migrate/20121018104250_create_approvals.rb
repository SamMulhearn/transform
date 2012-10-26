class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.integer :role_id, :null => false
      t.integer :rfc_id, :null => false
      t.boolean :closed, :null => false, :default => false
      t.boolean :approved, :null => false, :default => false
      t.timestamps
    end
  end
end
