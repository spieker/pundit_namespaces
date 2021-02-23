require 'spec_helper'

describe PunditNamespaces::NamespacedPolicyFinder do
  subject { described_class.new(Foo) }

  describe '#base_policy' do
    before :each do
      allow(subject).to receive(:name_from_method).and_return nil
      allow(subject).to receive(:name_from_model_name).and_return nil
      allow(subject).to receive(:name_from_class).and_return nil
      allow(subject).to receive(:name_from_symbol).and_return nil
      allow(subject).to receive(:name_from_array).and_return nil
      allow(subject).to receive(:name_from_object).and_return nil
    end

    it 'returns nil without an object given' do
      expect(described_class.new(nil).send :base_policy).to eql nil
    end

    it 'uses #name_from_method' do
      expect(subject).to receive(:name_from_method).and_return '1'
      expect(subject.send :base_policy).to eql '1'
    end

    it 'uses #name_from_model' do
      expect(subject).to receive(:name_from_model_name).and_return '2'
      expect(subject.send :base_policy).to eql '2Policy'
    end

    it 'uses #name_from_class' do
      expect(subject).to receive(:name_from_class).and_return '3'
      expect(subject.send :base_policy).to eql '3Policy'
    end

    it 'uses #name_from_symbol' do
      expect(subject).to receive(:name_from_symbol).and_return '4'
      expect(subject.send :base_policy).to eql '4Policy'
    end

    it 'uses #name_from_array' do
      expect(subject).to receive(:name_from_array).and_return '5'
      expect(subject.send :base_policy).to eql '5Policy'
    end

    it 'uses #name_from_object' do
      expect(subject).to receive(:name_from_object).and_return '6'
      expect(subject.send :base_policy).to eql '6Policy'
    end
  end

  describe '#name_from_method' do
    it 'is nil' do
      expect(subject.send :name_from_method, nil).to eql nil
    end

    it 'is nil without #policy_class on instance or class' do
      object = Class.new
      expect(subject.send :name_from_method, object).to eql nil
    end

    it 'returns the result of #policy_class on instance' do
      object = Class.new do; def policy_class; 'Foo'; end; end.new
      expect(subject.send :name_from_method, object).to eql 'Foo'
    end

    it 'returns the result of #policy_class on class' do
      object = Class.new do; def self.policy_class; 'Foo'; end; end.new
      expect(subject.send :name_from_method, object).to eql 'Foo'
    end
  end

  describe '#name_from_model_name' do
    it 'returns nil without #model_name on instance or class' do
      object = Class.new
      expect(subject.send :name_from_model_name, object).to eql nil
    end

    it 'returns the result of #policy_class on instance' do
      object = Class.new do; def model_name; 'Foo'; end; end.new
      expect(subject.send :name_from_model_name, object).to eql 'Foo'
    end

    it 'returns the result of #policy_class on class' do
      object = Class.new do; def self.model_name; 'Foo'; end; end.new
      expect(subject.send :name_from_model_name, object).to eql 'Foo'
    end
  end

  describe '#name_from_class' do
    it 'returns nil object is not a Class' do
      object = Class.new.new
      expect(subject.send :name_from_class, object).to eql nil
    end

    it 'returns the class name if class is given' do
      expect(subject.send :name_from_class, Foo).to eql 'Foo'
    end
  end

  describe '#name_from_symbol' do
    it 'returns nil object is not a Symbol' do
      object = 'foo'
      expect(subject.send :name_from_symbol, object).to eql nil
    end

    it 'returns the cammelized symbol' do
      expect(subject.send :name_from_symbol, :foo_bar).to eql 'FooBar'
    end
  end

  describe '#name_from_array' do
    it 'returns nil object is not an Array' do
      object = 'foo'
      expect(subject.send :name_from_array, object).to eql nil
    end

    it 'returns the joined and cammelized array' do
      expect(subject.send :name_from_array, ['foo', 'bar']).to eql 'Foo::Bar'
    end
  end

  describe '#name_from_object' do
    it 'returns the class name of the object' do
      expect(subject.send :name_from_object, Foo.new).to eql 'Foo'
    end
  end

  describe '#find' do
    it 'returns the namespaced result of #base_policy if namespace is set' do
      subject = described_class.new(Foo, 'Namespace')
      expect(subject).to receive(:base_policy).and_return 'FooPolicy'
      expect(subject.send(:find, nil)).to eql 'Namespace::FooPolicy'
    end

    it 'returns the plain result of #base_policy if no namespace is set' do
      expect(subject).to receive(:base_policy).and_return 'FooPolicy'
      expect(subject.send(:find, nil)).to eql 'FooPolicy'
    end
  end

  describe '#policy' do
    it 'returns the namespaced policy' do
      subject = described_class.new(Foo, 'Bar')
      expect(subject.policy).to eql Bar::FooPolicy
    end
  end

  describe '#scope' do
    it 'returns the namespaced scope' do
      subject = described_class.new(Foo, 'Bar')
      expect(subject.scope).to eql Bar::FooPolicy::Scope
    end
  end
end
