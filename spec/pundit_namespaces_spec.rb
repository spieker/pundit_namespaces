require 'spec_helper'

describe PunditNamespaces do
  it 'has a version number' do
    expect(PunditNamespaces::VERSION).not_to be nil
  end

  describe '#policy_scope' do
    it 'exists' do
      expect(described_class).to respond_to :policy_scope
    end

    it 'returns the namespaced scope' do
      scope = PunditNamespaces.policy_scope(nil, Foo, 'Bar')
      expect(scope).to eql :resolved_scope
    end

    it 'passes the namespace to the #new call' do
      expect(Bar::FooPolicy::Scope).to receive(:new).with(nil, Foo, 'Bar')
        .and_return double(resolve: :resolved_scope)
      PunditNamespaces.policy_scope(nil, Foo, 'Bar')
    end
  end

  describe '#policy_scope!' do
    it 'exists' do
      expect(described_class).to respond_to :policy_scope!
    end

    it 'returns the namespaced scope' do
      scope = PunditNamespaces.policy_scope!(nil, Foo, 'Bar')
      expect(scope).to eql :resolved_scope
    end

    it 'passes the namespace to the #new call' do
      expect(Bar::FooPolicy::Scope).to receive(:new).with(nil, Foo, 'Bar')
        .and_return double(resolve: :resolved_scope)
      PunditNamespaces.policy_scope!(nil, Foo, 'Bar')
    end
  end

  describe '#policy' do
    it 'exists' do
      expect(described_class).to respond_to :policy
    end

    it 'returns an instance of the policy' do
      policy = PunditNamespaces.policy(nil, Foo.new, 'Bar')
      expect(policy).to be_instance_of Bar::FooPolicy
    end

    it 'passes the namespace to the #new call' do
      expect(Bar::FooPolicy).to receive(:new).with(nil, Foo, 'Bar')
      PunditNamespaces.policy(nil, Foo, 'Bar')
    end
  end

  describe '#policy!' do
    it 'exists' do
      expect(described_class).to respond_to :policy!
    end

    it 'returns an instance of the policy' do
      policy = PunditNamespaces.policy!(nil, Foo.new, 'Bar')
      expect(policy).to be_instance_of Bar::FooPolicy
    end

    it 'passes the namespace to the #new call' do
      expect(Bar::FooPolicy).to receive(:new).with(nil, Foo, 'Bar')
      PunditNamespaces.policy!(nil, Foo, 'Bar')
    end
  end

  it 'adds a #pundit_namespace method' do
    subject = Class.new do
      include Pundit
      include PunditNamespaces
    end
    expect(subject.new).to respond_to :pundit_namespace
  end

  describe '#policy' do
    subject { Controller.new }

    it 'exists' do
      expect(subject).to respond_to :policy
    end

    it 'returns a namespaced policy' do
      expect(subject.policy(Foo.new)).to be_instance_of Bar::FooPolicy
    end
  end

  describe '#pundit_policy_scope' do
    subject { Controller.new }

    it 'returns a namespaced policy scope' do
      scope = subject.send :pundit_policy_scope, Foo
      expect(scope).to eql :resolved_scope
    end
  end
end
