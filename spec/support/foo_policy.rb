module Bar
  class FooPolicy < Struct.new(:user, :record)
    class Scope < Struct.new(:user, :scope)
      def resolve
        :resolved_scope
      end
    end
  end
end
