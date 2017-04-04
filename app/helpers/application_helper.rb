module ApplicationHelper
  def registered_user?
    current_user && current_user.registered_user?
  end

  def project_funder?
    current_user && current_user.project_funder?
  end

  def project_owner?
    current_user && current_user.project_owner?
  end

  def format_roles(role)
    role.split("_").join(" ")
  end
end
