class NotificatonController < ApplicationController
  def create
    EmailNotifier.inform(current_user, params[:email]).deliver_now
    flash[:notice] = "Successfully invited your friend to co-own this project."
    redirect_to root_url
  end
end
