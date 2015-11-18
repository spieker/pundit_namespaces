class Controller
  include Pundit
  include PunditNamespaces

  def pundit_namespace
    'Bar'
  end

  def current_user
    nil
  end
end
