# -*- coding: utf-8 -*-

class PdfReporterResults

   require 'prawn'
   require "prawn/measurement_extensions"

   # Medidas a partir del la esquina inferior izquierda del margen

   def initialize
      @pdf = Prawn::Document.new(:page_size   => 'LETTER', 
                                 :left_margin => 0.7.in,
                                 :right_margin => 0.4.in,
                                 :top_margin => 0.4.in,
                                 :bottom_margin => 0.4.in,
                                 :page_layout => :portrait,
                                 :template => 'public/pdf_templates/sequence_request_results.pdf')
   end
   
   def generate_pdf(file_name,model)
      pdf_body(model)
      @pdf.move_down 3.in
      table_results(model.sequence_request_details)
      @pdf.render_file(file_name)
   end

   def pdf_body(model)
      #PAYMENTE FORM
      x= 0.05
      y= 9.15

     #SEQUENCE REQUEST FORM
      #FOLIO Y FECHA
      @pdf.draw_text model.folio.to_s, :at => [(x+6.4).in,y.in]
      y=y-0.2
      @pdf.draw_text model.created_at.strftime("%d/%m/%Y"), :at => [(x+6.4).in,y.in]
     #DATOS DEL SOLICITANTE
     y=y-0.3
     @pdf.draw_text model.petitioner, :at => [(1.1).in, y.in]
     y=y-0.2
     @pdf.draw_text model.email, :at => [(1.1).in, y.in]
     @pdf.draw_text model.phone, :at => [(5.8).in, y.in]
     y=y-0.2
     @pdf.draw_text model.company, :at => [(2.2).in, y.in]
     y=y-0.2
     @pdf.draw_text model.group_leader, :at => [(2.2).in, y.in]
     y=y-0.4
     @pdf.draw_text model.payment_method_s, :at => [(1.3).in, y.in]
     @pdf.draw_text model.results_file, :at => [(4.6).in, y.in]

   end

   #TEST AREA TEST AREA TEST AREA TEST AREA TEST AREA TEST AREATEST AREA TEST AREA TEST AREA TEST AREA TEST AREA

   def table_results(model)
      #@pdf.table( [["foo", "bar", "bazbaz"], ["1", "2", "3"], ["1", "2", "3"], ["1", "2", "3"]],
      #   :cell_style => { :padding => 12 }, :width => @pdf.bounds.width)
      #
      #@pdf.move_down 12
      #
      #@pdf.table([["foo", "bar " * 15, "baz"],
      #      ["baz", "bar", "foo " * 15]], :cell_style => { :padding => 12 }) do
      #   cells.borders = []
      #
      #   # Use the row() and style() methods to select and style a row.
      #   style row(0), :border_width => 2, :borders => [:bottom]
      #
      #   # The style method can take a block, allowing you to customize
      #   # properties per-cell.
      #   style(columns(0..1)) { |cell| cell.borders |= [:right] }
      #end
      
      header = ['No','Nombre','Cap.','Tipo ADN','Oligo','Resultado','Observaciones']
      data = model.map.with_index{|e,i| [i+1, e.sample_name, e.capilar, e.adn_type_id, e.oligo_id, e.result, e.commentaries]}
      col_widths = {0 => 0.3.in, 1 => 1.in, 2 => 0.5.in,  3 => 1.in, 4 => 0.75.in, 5 => 1.5.in, 6 => 2.35.in}
      @pdf.font_size = 9
      @pdf.table([header] + data, :header => true, :column_widths => col_widths) do
         row(0).style(:font_style => :bold, :background_color => 'cccccc')
      end

   end

end
