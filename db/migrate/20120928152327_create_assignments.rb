class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|

      t.timestamps
      t.integer :role_id
      t.integer :user_id
    end
  end
end
