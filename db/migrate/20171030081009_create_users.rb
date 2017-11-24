class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table  :users do |t|
      t.string :name, null: false
      t.string :provider
      t.string :uid
      t.integer :authority, null: false, default: 0

    end
  end
end
