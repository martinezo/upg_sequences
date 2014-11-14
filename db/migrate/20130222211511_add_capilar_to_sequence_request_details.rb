class AddCapilarToSequenceRequestDetails < ActiveRecord::Migration
  def change
    add_column :sequence_request_details, :capilar, :string
  end
end
