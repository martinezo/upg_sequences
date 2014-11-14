class AddUserIdToSequenceRequests < ActiveRecord::Migration
  def self.up
    add_column :sequence_requests, :admin_user_id, :integer
  end

  def self.down
    remove_column :sequence_requests, :admin_user_id
  end
end
