class EmailNotifierMailer < ApplicationMailer
  def inform(current_user, contributor)
    @user = current_user
    mail(to: contributor, subject: "#{user.name} would you like to you to help with a crowdfunding project.")
  end
end
