class ChangeDescriptionToText < ActiveRecord::Migration[5.1]
  def change
  	change_column :tasks, :description, :text
  end
end
