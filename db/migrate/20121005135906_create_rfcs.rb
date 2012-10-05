class CreateRfcs < ActiveRecord::Migration
  def change
    create_table :rfcs do |t|

      t.timestamps
      t.integer :priority
      t.string :description
      t.text :risk
      t.text :mitigate_risks #take_out_of_service
      t.text :backup
      t.text :impact
      t.text :imp_plan
      t.text :pre_task
      t.text :post_task
      t.text :backout_plan
      t.datetime :start
      t.datetime :finish
      t.datetime :downtime_start
      t.datetime :downtime_finish

    end
  end
end
