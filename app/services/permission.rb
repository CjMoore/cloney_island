class Permission
  extend Forwardable
  attr_reader :user, :controller, :action

  def_delegators :user, :registered_user?


  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action

    case
    when user.registered_user?
      registered_user_permissions
    when user.project_funder?
      project_funder_permissions
    else
      guest_user_permissions
    end
  end

  private

  def guest_user_permissions
    return true if controller == "home"
    return true if controller == "sessions"
    return true if controller == "projects" && action.in?(["index", "show"])
    return true if controller == "users" && action.in?(["new", "create"])
  end

  def registered_user_permissions
    return true if controller == "home"
    return true if controller == "sessions"
    return true if controller == "users"
    return true if controller == "projects" && action.in?(["index", "show", "new", "create"])
    return true if controller == "comments" && action.in?(["create"])
    return true if controller == "user_funded_projects" && action.in?(["new"])
  end

  def project_funder_permissions
    return true if controller == "home"
    return true if controller == "sessions"
    return true if controller == "users"
    return true if controller == "projects" && action.in?(["index", "show", "new", "create"])
    return true if controller == "comments" && action.in?(["create"])
    return true if controller == "user_funded_projects" && action.in?(["new"])
  end
end
