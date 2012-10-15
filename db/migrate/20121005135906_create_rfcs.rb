class CreateRfcs < ActiveRecord::Migration
  def change
    create_table :rfcs do |t|

      t.timestamps
      t.integer :user_id
      t.integer :priority
      t.string :title
      t.text :status
      t.text :objective
      t.text :risk
      t.text :mitigate_risks #take_out_of_service #testing completed
      t.text :backup
      t.text :impact
      t.text :imp_plan
      t.text :pre_task
      t.text :post_task
      t.text :backout_plan
      t.date :imp_date
      t.time :downtime_start
      t.time :downtime_finish
    end
  end
end
