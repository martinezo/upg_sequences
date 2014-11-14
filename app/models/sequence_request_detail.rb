class SequenceRequestDetail < ActiveRecord::Base
  belongs_to :sequence_request

  OLIGO_OPTIONS = ['M13 for' , 'M13 rev' , 'T7' , 'T3' , 'Otro']
  ADN_TYPE_OPTIONS = ['Plasmido','PCR' ,'Otro']
  CAPILAR_TYPE = ['Corto', 'Largo']

  scope :by_ur, ->(ur_id) { where(:sequence_request_id  => SequenceRequest.select(:id).where(ur_id: ur_id, status: 'D-CO'))}

end
