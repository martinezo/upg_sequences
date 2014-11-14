# -*- coding: utf-8 -*-

class SequenceRequest < ActiveRecord::Base
  attr_accessor :upload_file

  has_many :sequence_request_details, :order=>"id ASC"
  belongs_to :ur
  accepts_nested_attributes_for :sequence_request_details, :allow_destroy => true

  validates :company, :petitioner, :email, :payment_method, :presence => true

  scope :by_ur_between, ->(start_date, end_date, ur_id) {where(created_at: (start_date..end_date), ur_id: ur_id, status: 'D-CO')}

  STATUS = {
    'A-LE' => 'Recibida',
    'B-PA' => 'Pagada',
    'C-CA' => 'Cancelada',
    'D-CO' => 'Concluida'}

  PMT_METHOD = {
      1 => 'UR',
      2 => 'Conacyt',
      3 => 'PAPIIT',
      4 => 'Efectivo',
      5 => 'Depósito bancario'
  }

  def folio_number
    return Time.now
  end

  before_save :set_folio_and_status

  def set_folio_and_status
    if  self.folio == nil
      self.folio = folio_number
    end
    if self.status == nil
      self.status=STATUS.key('Recibida')
      self.status_change_at=Time.now
    end
  end

  def paid_unpaid
     if self.status ==  STATUS.key('Recibida')
       self.update_attribute :status, STATUS.key('Pagada')
     elsif self.status ==  STATUS.key('Pagada')
       self.update_attribute :status, STATUS.key('Recibida')
     end
  end

  def set_sent_status
     self.update_attribute :status, STATUS.key('Concluida')
     self.update_attribute :status_change_at, Time.now
  end

  def cancel
     self.update_attribute :status, STATUS.key('Cancelada')
  end

  def seq_count
    self.sequence_request_details.count
  end

  def amount
    if self.inb_member then
      self.sequence_request_details.count * Admin::Price.find(2).price
    else
      self.sequence_request_details.count * Admin::Price.find(1).price
    end
  end

  def payment_method_s
    PMT_METHOD[self.payment_method]
  end

  def status_s
    STATUS[self.status]
  end

   #UPLOAD FILE
   #IMPORTANT add to _form view , form_for(@registration_forms, :html => {:multipart => true})
   def upload_file(upload,filename)
      #name =  folio + '_' +upload.original_filename
      directory = "public/results_files"
      # create the file path
      path = File.join(directory, filename)
      # write the file
      File.open(path, "wb") { |f| f.write(upload.tempfile.read) }
   end
end
