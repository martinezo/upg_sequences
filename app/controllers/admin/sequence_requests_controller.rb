# -*- coding: utf-8 -*-

class Admin::SequenceRequestsController < ApplicationController
  before_filter :authorize

  require 'pdf_reporter_results'
  require 'pdf_reporter'
  require 'xls_generator'
  layout 'application'

  def index
    @admin_sequence_requests = SequenceRequest.order("created_at DESC").paginate(:page => params[:page], :per_page => 16)

    respond_to do |format|
      format.html #idx.back.haml                         @admin_sequence_request= SequenceRequest.find(params[:id])

      format.xml { render :xml => @admin_sequence_requests }
    end
  end

  def paid_unpaid
    @admin_sequence_request= SequenceRequest.find(params[:id])
    @admin_sequence_request.paid_unpaid
    redirect_to :action => 'index'
  end

  def cancel
    @admin_sequence_request= SequenceRequest.find(params[:id])
    @admin_sequence_request.cancel
    redirect_to :action => 'index'
  end

  def show
    @admin_sequence_request= SequenceRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @admin_sequence_request }
    end
  end

  # GET /sequence_requests/1/edit
  def edit
    @admin_sequence_request= SequenceRequest.find(params[:id])
  end

  # PUT /sequence_requests/1
  # PUT /sequence_requests/1.xml
  def update
    @admin_sequence_request= SequenceRequest.find(params[:id])

    #REMOVE results_file
    if params[:remove_results_file]=='true' then
      @admin_sequence_request.results_file = nil
    end

    #UPLOAD FILE
    @admin_sequence_request.results_file=params[:sequence_request][:upload_file].original_filename unless params[:sequence_request][:upload_file].nil?


    respond_to do |format|
      if @admin_sequence_request.update_attributes(params[:sequence_request])

        #UPLOAD FILE - IMPORTANT add to _form view , form_for(@model, :html => {:multipart => true})
        @admin_sequence_request.upload_file(params[:sequence_request][:upload_file], "#{@admin_sequence_request.folio.to_s}_#{@admin_sequence_request.results_file}") unless params[:sequence_request][:upload_file].nil?

        #GENERATE PDF REQUEST
        pdf_file_name = "public/pdf_files/#{@admin_sequence_request.folio}.pdf"
        generate_pdf_request(pdf_file_name,@admin_sequence_request)

        format.html { redirect_to admin_sequence_request_path(@admin_sequence_request, :notice => 'Sequence request was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @admin_sequence_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_sequence_request_detail

  end

  def reports_by_ur

  end

  def generate_reports_by_ur
    report_params = params[:report]
    start_date = Date.new(report_params['start_date(1i)'].to_i,report_params['start_date(2i)'].to_i,report_params['start_date(3i)'].to_i).beginning_of_day
    end_date = Date.new(report_params['end_date(1i)'].to_i,report_params['end_date(2i)'].to_i,report_params['end_date(3i)'].to_i).beginning_of_day
    ur_id = report_params[:ur_id] == '999' ? 'id > 0' : "id = #{report_params[:ur_id]}"
    urs = Ur.select(:id).where(ur_id).all.map{|v| v[:id]}
    if params[:generate]
      filename = 'public/pdf_files/sequence_reports.pdf'
      pdf_general_report(start_date, end_date, urs, filename)
      send_file filename, filename: "solicitudes_de_#{start_date.strftime('%Y%m%d')}_a_#{end_date.strftime('%Y%m%d')}.pdf", :type => "registration/xls"
    else
      puts 'SENT XXXXXXXXXXXXXXXXXXXXXXXXXX'
    end
  end


  require 'prawn'
  require "prawn/measurement_extensions"
  def pdf_general_report(start_date, end_date,urs, filename)
    # def initialize
    @pdf = Prawn::Document.new(:page_size   => 'LETTER',
                               :left_margin => 0.7.in,
                               :right_margin => 0.4.in,
                               :top_margin => 0.4.in,
                               :bottom_margin => 0.4.in,
                               :page_layout => :portrait,
                               :template => 'public/pdf_templates/sequence_request_reports.pdf')
    # end

    x= 0.05
    y= 9.15

    # FECHA
    @pdf.draw_text Date.today.strftime("%d/%m/%Y"), :at => [(x+6.4).in,y.in]
    y=y-0.3

    # PERIOD
    @pdf.draw_text "del #{I18n.l(start_date, :format => :long)} al #{I18n.l(end_date, :format => :long)}", :at => [(x+0.75).in,y.in]

    # SEQUENCES
    @pdf.move_down 1.75.in
    header = ['FOLIO','FECHA','SOLICITANTE.','CANTIDAD','IMPORTE']

    col_widths = {0 => 0.75.in, 1 => 1.in, 2 => 4.in, 3 => 0.75.in, 4 => 0.9.in}
    @pdf.font_size = 8
    total = 0
    urs.each do |ur|
      seq_req = SequenceRequest.by_ur_between(start_date,end_date,ur)
      if seq_req.size > 0
        @pdf.text Ur.find(ur).name_and_responsible, :size => 14
        data=seq_req.map{|r| [r.folio, I18n.l(r.created_at, :format => :short), r.petitioner, r.seq_count, r.amount]}

        @pdf.table([header] + data, :header => true, :column_widths => col_widths ) do
          row(0).style(:font_style => :bold, :background_color => 'cccccc')
          column(4).style :align => :right
        end

        # SUB-TOTAL
        total_ur = SequenceRequestDetail.by_ur(ur).size * Admin::Price.find(2).price
        total = total + total_ur
        data = [['TOTAL UR:', total_ur]]
        @pdf.table data, :column_widths => {0 => 6.5.in, 1 => 0.9.in} do
          column(0).style :align => :right
          column(1).style :align => :right, :background_color => 'cccccc'
        end

        @pdf.move_down 0.2.in
      end
    end

    # TOTAL
    data = [['TOTAL:', total]]
    @pdf.table data, :column_widths => {0 => 6.5.in, 1 => 0.9.in} do
      row(0).style(:font_style => :bold, :background_color => 'cccccc')
      column(0).style :align => :right
      column(1).style :align => :right
    end

    @pdf.render_file(filename)

  end

  def send_results
    @admin_sequence_request= SequenceRequest.find(params[:id])

    #GENERATE PDF  RESULTS
    pdf_file_name = "public/pdf_files/#{@admin_sequence_request.folio}_resultados.pdf"
    generate_pdf_results(pdf_file_name, @admin_sequence_request)

    #SENDING MAILS
    admin_emails = Admin::User.select("email").where("follow_requests = ?", true).map(&:email).join ','
    RequestMailer.request_sent_results(@admin_sequence_request.petitioner, @admin_sequence_request.email, admin_emails, @admin_sequence_request.folio, @admin_sequence_request.results_file).deliver

    #CHANGE STATUS
    @admin_sequence_request.set_sent_status
  end

  def generate_pdf_request(file_name,model)
     pdf = PdfReporter.new
     pdf.generate_pdf(file_name, model)
  end

  def generate_pdf_results(file_name, model)
    pdf = PdfReporterResults.new
    pdf.generate_pdf(file_name, model)
  end

  def download_file
     send_file params[:file_name], :type=>"registration/pdf"
  end

  def generate_and_download_xls
    @admin_sequence_request = SequenceRequest.order("created_at DESC")
    file_name =  Time.now.strftime("Solicitudes_de_secuencias_%m%d%Y.xls")
    xls = XlsGenerator.new
    xls.generate_xls(file_name,@admin_sequence_request,'Solicitudes')
    send_file "public/xls_files/#{file_name}", :type => "registration/xls"
  end

end