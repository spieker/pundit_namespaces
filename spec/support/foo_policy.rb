module Bar
  class FooPolicy < Struct.new(:user, :record, :namespace)
    class Scope < Struct.new(:user, :scope, :namespace)
      def resolve
        :resolved_scope
      end
    end
  end
end
