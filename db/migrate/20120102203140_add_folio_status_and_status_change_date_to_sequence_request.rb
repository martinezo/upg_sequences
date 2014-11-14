class AddFolioStatusAndStatusChangeDateToSequenceRequest < ActiveRecord::Migration
  def self.up
    add_column :sequence_requests, :folio, :integer
    add_column :sequence_requests, :status, :string
    add_column :sequence_requests, :status_change_at, :datetime
  end

  def self.down
    remove_column :sequence_requests, :status_change_at
    remove_column :sequence_requests, :status
    remove_column :sequence_requests, :folio
  end
end
