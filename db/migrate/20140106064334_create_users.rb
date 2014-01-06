class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.timestamps :created_at
      t.timestamps :updated_at

      t.timestamps
    end
  end
end
