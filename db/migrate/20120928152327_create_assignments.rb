class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.timestamps
      t.integer :role_id, :null => false
      t.integer :user_id, :null => false
    end
  end
end
