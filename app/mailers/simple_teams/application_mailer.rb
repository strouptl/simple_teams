module SimpleTeams
  class ApplicationMailer < ActionMailer::Base
    default from: SimpleTeams.from_address
    layout "mailer"
  end
end
