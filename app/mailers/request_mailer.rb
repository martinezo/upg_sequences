# -*- coding: utf-8 -*-

class RequestMailer < ActionMailer::Base
  default :from => 'upg@inb.unam.mx'

   def request_notification(name, email, folio)
      @name = name
      @folio = folio
      attachments["#{folio}.pdf"] = File.read("public/pdf_files/#{folio}.pdf")
      mail(:to => email, :subject => "Solicitud de secuencias #{folio}")
   end

   def request_notification_admin(name, emails, folio)
      @name = name
      @folio = folio
      attachments["#{folio}.pdf"] = File.read("public/pdf_files/#{folio}.pdf")
      mail(:to => emails, :subject => "Nueva solicitud de secuencias #{folio}")
   end

   def request_notification_bank_deposit(email, folio)
     @folio = folio
     attachments["#{folio}.pdf"] = File.read("public/pdf_files/#{folio}.pdf")
     mail(:to => email, :subject => "Solicitud de ficha de depósito")
   end

   def request_sent_results(name, emails, emails_cc, folio, results_file)
      @name = name
      @folio = folio
      attachments["#{folio}_resultados.pdf"] = File.read("public/pdf_files/#{folio}_resultados.pdf")
      attachments["#{folio}_#{results_file}"] = File.read("public/results_files/#{folio}_#{results_file}") unless results_file.nil?
      mail(:to => emails, :cc => emails_cc, :subject => "Resultados solicitud de secuencias #{folio}")
   end

end
