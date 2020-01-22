class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :priority
      t.boolean :is_done, :default => false
      
      t.timestamps
    end
  end
end
