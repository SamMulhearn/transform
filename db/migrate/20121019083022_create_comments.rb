class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :rfc_id, :null => false
      t.integer :user_id
      t.text :comment
      t.text :css_class #Used for styling approval generated comments
      t.timestamps
    end
  end
end
