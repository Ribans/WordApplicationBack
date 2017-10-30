class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table  :users do |t|
      t.string :users, :provider
      t.string :users, :uid
      t.string :users, :name
      t.integer :users, :authority, null: false, default: 0

    end
  end
end
