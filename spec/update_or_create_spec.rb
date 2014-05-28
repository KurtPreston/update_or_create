require 'spec_helper'

describe UpdateOrCreate do
  before(:each) do
    define_model('TestClass', {
      :name => :string,
      :test_column => :string
    })
    define_model('TestAssociation', {
      :name => :string,
      :test_column => :string,
      :test_class_id => :integer
    })

    TestClass.class_eval do
      validates_format_of :name, :with => /[^!]+\z/
      has_many :test_associations
    end
    TestAssociation.class_eval do
      validates_format_of :name, :with => /[^!]+\z/
      belongs_to :test_class
    end

    @test_object = TestClass.create(:name => "Valid")
  end

  describe "Validate test classes" do
    it "TestClass should validate name format" do
      TestClass.new(name: "Invalid!").should_not be_valid
    end

    it "TestAssociation should validate name format" do
      TestAssociation.new(name: "Invalid!").should_not be_valid
    end
  end

  describe "ActiveRecord::Base#update_or_create" do
    it "updates existing fields when it finds them" do
      a = TestClass.create(name: 'Test 1', test_column: "A")
      TestClass.update_or_create(name: "Test 1", test_column: "B")
      TestClass.count.should == 1
      a.reload.test_column.should == "B"
    end
  end

  describe "ActiveRecord::Associations::AssociationProxy.factory_spawn" do
    it "creates a new object without saving" do
      @test_object.test_associations.factory_spawn.class.should == TestAssociation
      @test_object.test_associations.factory_spawn(:name => 'Test Association').name.should == 'Test Association'
      @test_object.test_associations.factory_spawn.id.should be_nil
      @test_object.test_associations.factory_spawn.test_class.should == @test_object.reload
    end
  end
end
