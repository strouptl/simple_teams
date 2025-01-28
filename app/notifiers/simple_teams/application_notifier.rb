class ApplicationNotifier < Noticed::Event
  #deliver_by :email, mailer: "NotificationMailer", :method => "notification"

end
