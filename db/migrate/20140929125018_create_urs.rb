class CreateUrs < ActiveRecord::Migration
  def change
    create_table :urs do |t|
      t.string :name
      t.string :responsible
      t.string :mail

      t.timestamps
    end
  end
end
