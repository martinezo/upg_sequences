# -*- coding: utf-8 -*-

class PdfReporter

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
                                 :template => 'public/pdf_templates/sequence_request.pdf')
   end
   
   def generate_pdf(file_name,model)
      pdf_body(model)
      #table_test
      @pdf.render_file(file_name)
   end

   def pdf_body(model)
      ##PAYMENTE FORM
      #x= 1.1
      #y= 10.05
      #
      ##FOLIO Y FECHA
      #@pdf.draw_text model.folio.to_s, :at => [(6.45).in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.created_at.strftime("%d/%m/%Y"), :at => [(6.45).in,y.in]
      ##CONCEPTO Y CANTIDAD
      #y=y-0.3
      #@pdf.draw_text "#{model.seq_count} Secuencia(s) de ácidos nucleicos", :at => [(1.0).in,y.in]
      #@pdf.draw_text "$ #{"%.2f" % model.amount}", :at => [(6.45).in,y.in]
      ##FIRMA
      #@pdf.text_box model.group_leader, :at => [0.in,(8.55).in], :align => :center

     x= 1.1
     y= 9.05

     #SEQUENCE REQUEST FORM
      #FOLIO Y FECHA

      @pdf.draw_text model.folio.to_s, :at => [(6.45).in,y.in]
      y=y-0.2
      @pdf.draw_text model.created_at.strftime("%d/%m/%Y"), :at => [(6.45).in,y.in]
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
     if model.inb_member then
       @pdf.draw_text 'SI', :at => [(7.1).in, y.in]
     else
       @pdf.draw_text 'NO', :at => [(7.1).in, y.in]
     end
     y=y-0.2
     if model.ur_id == 0 then
       @pdf.draw_text 'No definida', :at => [(1.70).in, y.in]
     else
       @pdf.draw_text model.ur.name_and_responsible, :at => [(1.70).in, y.in]
     end
     #IMPORTE Y CANTIDAD
     y=y-4.8
     @pdf.draw_text model.seq_count, :at => [(6.45).in,y.in]
     y=y-0.2
     @pdf.draw_text "$ #{"%.2f" % model.amount}", :at => [(6.45).in,y.in]

     #SECUENCIAS
     @pdf.font_size = 9
     y=6.55
     x=0.05
     c=1
     model.sequence_request_details.each { |srd|
       #NO
       @pdf.draw_text c, :at => [x.in, y.in]
       #NOMBRE
       @pdf.draw_text srd.sample_name, :at => [(x+0.3).in, y.in]
       #CAPILAR
       @pdf.draw_text srd.capilar, :at => [(x+1.6).in, y.in]
       #ADN TYPE
       @pdf.draw_text srd.adn_type_id, :at => [(x+2.2).in, y.in]
       #OLIGO
       @pdf.draw_text srd.oligo_id, :at => [(x+3.0).in, y.in]
       y=y-0.2
       c=c+1
       if c==18 then
         y=4.25
         x=3.85
       end
     }


      ##DATOS PERSONALES
      #y=y-0.2
      #@pdf.draw_text "#{model.p_name} #{model.p_last_name}", :at => [x.in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.p_email, :at => [x.in,y.in]
      #@pdf.draw_text model.p_phone, :at => [(x+4.7).in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.p_degree, :at => [x.in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.p_mastery, :at => [x.in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.p_phd, :at => [x.in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.p_date_last_degree.strftime("%d/%m/%Y"), :at => [(x+2.4).in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.p_workplace, :at => [(x+1.4).in,y.in]
      #y=y-0.3
      #@pdf.text_box model.p_purpose, :at => [(x-1).in, y.in], :width => 7.2.in, :height => 0.5.in, :size => 10
      #
      ##FICHA DE PAGO (COPIA PARTICIPANTE)
      #y=y-0.9
      #@pdf.draw_text model.folio.to_s, :at => [(x+5.35).in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.created_at.strftime("%d/%m/%Y"), :at => [(x+5.35).in,y.in]
      #y=y-0.2
      #@pdf.draw_text "#{model.p_name} #{model.p_last_name}", :at => [x.in,y.in]
      #@pdf.draw_text model.p_phone, :at => [(x+4.9).in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.i_corporate_name, :at => [x.in,y.in]
      #@pdf.draw_text model.i_rfc, :at => [(x+4.9).in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.i_street_no, :at => [x.in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.i_neighborhood, :at => [x.in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.i_city, :at => [x.in,y.in]
      #@pdf.draw_text model.state.name, :at => [(x+2.9).in,y.in]
      #@pdf.draw_text model.i_zip_code, :at => [(x+5.3).in,y.in]
      #
      ##FICHA DE PAGO (COPIA ADMINISTRACION)
      #y=y-1.1
      #@pdf.draw_text model.folio.to_s, :at => [(x+5.35).in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.created_at.strftime("%d/%m/%Y"), :at => [(x+5.35).in,y.in]
      #y=y-0.2
      #@pdf.draw_text "#{model.p_name} #{model.p_last_name}", :at => [x.in,y.in]
      #@pdf.draw_text model.p_phone, :at => [(x+4.9).in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.i_corporate_name, :at => [x.in,y.in]
      #@pdf.draw_text model.i_rfc, :at => [(x+4.9).in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.i_street_no, :at => [x.in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.i_neighborhood, :at => [x.in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.i_city, :at => [x.in,y.in]
      #@pdf.draw_text model.state.name, :at => [(x+2.9).in,y.in]
      #@pdf.draw_text model.i_zip_code, :at => [(x+5.3).in,y.in]
      #
      ##FICHA DE PAGO BANCO
      #y=y-1.2
      #@pdf.draw_text model.folio.to_s, :at => [(x+5.35).in,y.in]
      #y=y-0.2
      #@pdf.draw_text model.created_at.strftime("%d/%m/%Y"), :at => [(x+5.35).in,y.in]
      #y=y-0.3
      #@pdf.draw_text "#{model.p_name} #{model.p_last_name}", :at => [x.in,y.in]
      #@pdf.draw_text model.p_phone, :at => [(x+4.9).in,y.in]
   end

   #TEST AREA TEST AREA TEST AREA TEST AREA TEST AREA TEST AREATEST AREA TEST AREA TEST AREA TEST AREA TEST AREA

   def table_test
      @pdf.table( [["foo", "bar", "bazbaz"], ["1", "2", "3"], ["1", "2", "3"], ["1", "2", "3"]],
         :cell_style => { :padding => 12 }, :width => @pdf.bounds.width)

      @pdf.move_down 12
      
      @pdf.table([["foo", "bar " * 15, "baz"],
            ["baz", "bar", "foo " * 15]], :cell_style => { :padding => 12 }) do
         cells.borders = []

         # Use the row() and style() methods to select and style a row.
         style row(0), :border_width => 2, :borders => [:bottom]

         # The style method can take a block, allowing you to customize
         # properties per-cell.
         style(columns(0..1)) { |cell| cell.borders |= [:right] }
      end
      
      header = %w[Name Occupation]
      data = ["Bender Bending Rodriguez", "Bender"]

      @pdf.table([header] + [data] * 50, :header => true) do
         #row(0).style(:font_style => :bold, :background_color => 'cccccc')
      end

   end

end
