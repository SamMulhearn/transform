class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.timestamps
      t.string :name
      t.boolean :approvalgroup, :null => false, :default => true
      t.boolean :mandatory_appr, :null => false, :default => false
    end
  end
end