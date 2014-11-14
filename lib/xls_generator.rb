# -*- coding: utf-8 -*-
# To change this template, choose Tools | Templates
# and open the template in the editor.


class XlsGenerator

  require 'spreadsheet'
  #http://spreadsheet.rubyforge.org/file.GUIDE.html


  def generate_xls(filename,model,sheet_name)
    book = Spreadsheet::Workbook.new
    @sheet1 = book.create_worksheet :name => sheet_name
    @sheet1[0,0] = Time.now.strftime("Solicitud de Secuencias de Acidos Nucleicos %m/%d/%Y")
    headers
    records(model)
    book.write "public/xls_files/#{filename}"
  end

  def headers
    @sheet1[2,0] = 'Folio'
    @sheet1[2,1] = 'Fecha'
    @sheet1[2,2] = 'Solicitante'
    @sheet1[2,3] = 'Jefe de Grupo'
    @sheet1[2,4] = 'Empresa/Institución'
    @sheet1[2,5] = 'Telefono'
    @sheet1[2,6] = 'Miembro INB'
    @sheet1[2,7] = 'Secuencias'
    @sheet1[2,8] = 'Importe'
    @sheet1[2,9] = 'Forma de pago'
    @sheet1[2,10] = 'Archivo de resultados'
    @sheet1[2,11] = 'Estatus'

    #Formating
    bold = Spreadsheet::Format.new :weight => :bold
    @sheet1.row(0).set_format(0,bold)
    16.times do |x| @sheet1.row(2).set_format(x,bold) end
  end

  def records(model)
    row = 3
    model.each do |r|
      @sheet1[row,0] = r.folio
      @sheet1[row,1] = r.created_at
      @sheet1[row,2] = r.petitioner
      @sheet1[row,3] = r.group_leader
      @sheet1[row,4] = r.company
      @sheet1[row,5] = r.phone
      @sheet1[row,6] = r.inb_member
      @sheet1[row,7] = r.seq_count
      @sheet1[row,8] = r.amount
      @sheet1[row,9] = r.payment_method_s
      @sheet1[row,10] = r.results_file
      @sheet1[row,11] = SequenceRequest::STATUS[r.status]

      row = row +1
    end
  end
 
end
