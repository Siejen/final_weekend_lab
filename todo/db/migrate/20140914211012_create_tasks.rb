class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.date :due_date
      t.boolean :task_complete

      t.timestamps
    end
  end
end
