class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :expiry_date
      t.integer :user_id
    end
  end
end

