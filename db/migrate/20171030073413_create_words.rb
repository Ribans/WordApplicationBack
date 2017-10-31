class CreateWords < ActiveRecord::Migration[5.1]
  def change
    create_table :words do |t|
      t.string :japanese
      t.string :english
      t.string :meaning
      t.integer :category, null: false, default: 0 
    end
  end
end
