#MAILER CONFIGURATION

#config.action_mailer.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
   :address => "correo.inb.unam.mx" ,
   :port => 25,
   :domain => "inb.unam.mx" ,
    #:authentication => :login,
    #:user_name => "martinezo",
    #:password => "xxxxxxx"
}


