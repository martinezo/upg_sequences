class AddResutsFileToSequenceRequest < ActiveRecord::Migration
  def change
    add_column :sequence_requests, :results_file, :string
  end
end
