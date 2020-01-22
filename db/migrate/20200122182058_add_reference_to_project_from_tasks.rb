class AddReferenceToProjectFromTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :project, index: true, foreign_key: true
    remove_reference :tasks, :user, index: true
  end
end
