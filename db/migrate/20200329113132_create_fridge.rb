class CreateFridge < ActiveRecord::Migration
  def change
    create_table :fridges do |t|
      t.string :name
      t.integer :user_capacity
    end
  end
end
