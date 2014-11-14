# -*- coding: utf-8 -*-

class SequenceRequestsController < ApplicationController
  # GET /sequence_requests
  # GET /sequence_requests.xml

  require 'pdf_reporter'
  layout 'application'

  # GET /sequence_requests/new
  # GET /sequence_requests/new.xml
  def new
    @sequence_request = SequenceRequest.new
    @sequence_request.sequence_request_details.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sequence_request }
    end
  end

  # POST /sequence_requests
  # POST /sequence_requests.xml
  def create
    @sequence_request = SequenceRequest.new(params[:sequence_request])

    #respond_to do |format|
    #  if @sequence_request.save
    #    format.html { redirect_to(@sequence_request, :notice => 'Sequence request was successfully created.') }
    #    format.xml { render :xml => @sequence_request, :status => :created, :location => @sequence_request }
    #  else
    #    format.html { render :action => "new" }
    #    format.xml { render :xml => @sequence_request.errors, :status => :unprocessable_entity }
    #  end
    #end

    respond_to do |format|
      if @sequence_request.save
        #GENERATE PDF
        pdf_file_name = "public/pdf_files/#{@sequence_request.folio}.pdf"
        generate_pdf(pdf_file_name,@sequence_request)

        #SENDING MAILS
        admin_emails = Admin::User.select("email").where("follow_requests = ?", true).map(&:email).join ','
        RequestMailer.request_notification(@sequence_request.petitioner, @sequence_request.email, @sequence_request.folio).deliver
        unless admin_emails.empty?
           RequestMailer.request_notification_admin(@sequence_request.petitioner, admin_emails, @sequence_request.folio).deliver
        end

        msg = "Tu solicitud ha sido enviada correctamente con el folio #{@sequence_request.folio}."

        if @sequence_request.payment_method == 5 then
          RequestMailer.request_notification_bank_deposit('ingresos@inb.unam.mx', @sequence_request.folio).deliver
          msg = msg + ' En breve recibirás vía email la ficha de depósito para que efectúes el pago correspondiente.'
        end

        format.html { redirect_to sequence_request_sent_path(:notice => msg, :file_name => pdf_file_name) }
        format.xml  { render :xml => @sequence_request, :status => :created, :location => @sequence_request }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sequence_request.errors, :status => :unprocessable_entity }
      end
    end

  end





  def add_sequence_request_detail

  end

  def generate_pdf(file_name,model)
     pdf = PdfReporter.new
     pdf.generate_pdf(file_name, model)
  end

  def sent
      respond_to do |format|
         format.html
         format.xml  { render :xml => @sequence_request }
      end
   end


  def download_file
     send_file params[:file_name], :type=>"registration/pdf"
  end

=begin
    # GET /sequence_requests/1
  # GET /sequence_requests/1.xml
  def show
    @sequence_request = SequenceRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sequence_request }
    end
  end

   # DELETE /sequence_requests/1
  # DELETE /sequence_requests/1.xml
  def destroy
    @sequence_request = SequenceRequest.find(params[:id])
    @sequence_request.destroy

    respond_to do |format|
      format.html { redirect_to(sequence_requests_url) }
      format.xml  { head :ok }
    end
  end

    # PUT /sequence_requests/1
  # PUT /sequence_requests/1.xml
  def update
    @sequence_request = SequenceRequest.find(params[:id])

    respond_to do |format|
      if @sequence_request.update_attributes(params[:sequence_request])
        format.html { redirect_to(@sequence_request, :notice => 'Sequence request was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sequence_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  def index
    @sequence_requests = SequenceRequest.all

    respond_to do |format|
      format.html # index.back.erb
      format.xml  { render :xml => @sequence_requests }
    end
  end

   # GET /sequence_requests/1/edit
  def edit
    @sequence_request = SequenceRequest.find(params[:id])
  end
=end

end
