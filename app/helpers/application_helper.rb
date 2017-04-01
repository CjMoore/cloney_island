module ApplicationHelper
  def registered_user?
    current_user && current_user.registered_user?
  end

  def project_funder?
    current_user && current_user.project_funder?
  end
end
