class Ur < ActiveRecord::Base

  default_scope order('id ASC')
  has_many :sequence_requestsrs
  attr_accessible :mail, :name, :responsible
  attr_accessor :name_and_responsible

  def name_and_responsible
    "#{name} (#{responsible})"
  end

  def self.ur_sel
    (Ur.where('id>0').map{|r| [r.name_and_responsible, r.id]}).unshift ['Todas',999]
  end
end
