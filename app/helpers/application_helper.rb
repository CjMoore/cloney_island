module ApplicationHelper
  def registered_user?
    current_user && current_user.registered_user?
  end

  def project_owner?
    current_user && current_user.project_owner?
  end
end
