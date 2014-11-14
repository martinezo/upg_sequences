class AddColumnToSequenceRequests < ActiveRecord::Migration
  def change
		add_column :sequence_requests, :ur_id, :integer, :default => 0
  end
end
