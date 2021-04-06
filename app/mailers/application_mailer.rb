class ApplicationMailer < ActionMailer::Base
  default from: 'joskamarin@gmail.com', cc: 'paomg.9614@gmail.com'
  layout 'mailer'
end

