class CreateSequenceRequests < ActiveRecord::Migration
  def self.up
    create_table :sequence_requests do |t|
      t.string :company
      t.string :petitioner
      t.string :email
      t.string :phone
      t.string :group_leader
      t.integer :payment_method

      t.timestamps
    end
  end

  def self.down
    drop_table :sequence_requests
  end
end
