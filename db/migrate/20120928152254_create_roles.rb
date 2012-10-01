class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|

      t.timestamps
      t.string :name
      t.string :description
      t.boolean :approvalgroup
    end
  end
end
