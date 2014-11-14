class CreateSequenceRequestDetails < ActiveRecord::Migration
  def self.up
    create_table :sequence_request_details do |t|
      t.integer :sequence_request_id
      t.string :sample_name
      t.string :adn_type_id
      t.string :oligo_id
      t.string :result
      t.string :commentaries

      t.timestamps
    end
  end

  def self.down
    drop_table :sequence_request_details
  end
end
