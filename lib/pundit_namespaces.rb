require "pundit_namespaces/version"
require "pundit_namespaces/namespaced_policy_finder"

module PunditNamespaces
  class <<self
    def policy_scope(user, scope, namespace = nil)
      policy_scope = NamespacedPolicyFinder.new(scope, namespace).scope
      policy_scope.new(user, scope, namespace).resolve if policy_scope
    end

    def policy_scope!(user, scope, namespace = nil)
      policy_scope = NamespacedPolicyFinder.new(scope, namespace).scope!
      policy_scope.new(user, scope, namespace).resolve
    end

    def policy(user, record, namespace = nil)
      policy = NamespacedPolicyFinder.new(record, namespace).policy
      policy.new(user, record, namespace) if policy
    end

    def policy!(user, record, namespace = nil)
      policy = NamespacedPolicyFinder.new(record, namespace).policy!
      policy.new(user, record, namespace)
    end
  end

  def pundit_namespace
  end

  def policy(record)
    user      = pundit_user
    namespace = pundit_namespace
    policies[record] ||= PunditNamespaces.policy!(user, record, namespace)
  end

  def policies
    @_pundit_policies ||= {}
    @_pundit_policies[pundit_namespace] ||= {}
  end

  def policy_scopes
    @_pundit_policy_scopes ||= {}
    @_pundit_policy_scopes[pundit_namespace] ||= {}
  end

  private

  def pundit_policy_scope(scope)
    user      = pundit_user
    namespace = pundit_namespace
    scopes    = policy_scopes
    scopes[scope] ||= PunditNamespaces.policy_scope!(user, scope, namespace)
  end
end
