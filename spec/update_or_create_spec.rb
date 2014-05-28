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

    @test_object = TestClass.create(name: 'Test 1', test_column: "A")
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
      TestClass.update_or_create(name: "Test 1") do |a|
        a.test_column = "B"
      end
      TestClass.count.should == 1
      @test_object.reload.test_column.should == "B"
    end

    it "creates a new entry otherwise" do
      b = TestClass.update_or_create(name: "Test 2") do |a|
        a.test_column = "B"
      end
      TestClass.count.should == 2
      @test_object.reload.test_column.should == "A"
      b.name.should == "Test 2"
      b.test_column.should == "B"
    end
  end

  describe "ActiveRecord::Associations::AssociationProxy.update_or_create" do
    it "updates an association if found" do
      assoc1 = @test_object.test_associations.create(name: 'Association 1', test_column: 'C')
      @test_object.test_associations.update_or_create(name: 'Association 1') do |a|
        a.test_column = 'D'
      end
      assoc1.reload.test_column.should == 'D'
      TestAssociation.count.should == 1
    end

    it "creates a new record if the association is not found" do
      assoc1 = @test_object.test_associations.create(name: 'Association 1', test_column: 'C')
      assoc2 = @test_object.test_associations.update_or_create(name: 'Association 2') do |a|
        a.test_column = 'D'
      end
      assoc1.reload.test_column.should == 'C'
      TestAssociation.count.should == 2
      assoc2.name.should == 'Association 2'
      assoc2.test_column.should == 'D'
    end
  end
end
