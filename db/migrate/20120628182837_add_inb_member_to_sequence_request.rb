class AddInbMemberToSequenceRequest < ActiveRecord::Migration
  def change
    add_column :sequence_requests, :inb_member, :boolean
  end
end
