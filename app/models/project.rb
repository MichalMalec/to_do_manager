class Project < ApplicationRecord
  has_many :tasks, -> { order("tasks.priority ASC") }
  belongs_to :user
end
