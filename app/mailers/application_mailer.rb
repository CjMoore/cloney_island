class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@cloneyisland.herokuapp.com'
  layout 'mailer'
end
