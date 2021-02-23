require 'pundit'

module PunditNamespaces
  class NamespacedPolicyFinder < Pundit::PolicyFinder
    attr_reader :namespace

    def initialize(object, namespace = nil)
      super(object)
      @namespace = namespace
    end

    private
    def base_policy
      return nil if object.nil?
      klass = name_from_method(object)
      return klass if klass
      klass = name_from_model_name(object) ||
              name_from_class(object) ||
              name_from_symbol(object) ||
              name_from_array(object) ||
              name_from_object(object)
      "#{klass}#{Pundit::SUFFIX}"
    end

    def name_from_method(object)
      if object.respond_to?(:policy_class)
        object.policy_class
      elsif object.class.respond_to?(:policy_class)
        object.class.policy_class
      else
        nil
      end
    end

    def name_from_model_name(object)
      if object.respond_to?(:model_name)
        object.model_name
      elsif object.class.respond_to?(:model_name)
        object.class.model_name
      else
        nil
      end
    end

    def name_from_class(object)
      return nil unless object.is_a?(Class)
      object.name
    end

    def name_from_symbol(object)
      return nil unless object.is_a?(Symbol)
      object.to_s.camelize
    end

    def name_from_array(object)
      return nil unless object.is_a?(Array)
      object.join('/').camelize
    end

    def name_from_object(object)
      name_from_class(object.class)
    end

    def find(_object)
      [namespace, base_policy].compact.flatten.join('::')
    end
  end
end
