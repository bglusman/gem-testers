require 'spec_helper'

describe Version do
  before do
    @valid_attributes = {
      :number => '1.0.0.0',
      :rubygem_id => 1
    }
    @gem = Factory.create :rubygem
  end

  it "should accept valid attributes to create a new object" do
    Version.create! @valid_attributes
  end

  it 'should not create 2 of the same version #s within the scope of a rubygem' do
    Factory.create :version, number: '1.0.0', rubygem_id: @gem.id
    v = Factory.build :version, number: '1.0.0', rubygem_id: @gem.id
    v.save.should be_false
  end

  
  it 'should allow the same version #s outside the scope of a rubygem' do
    gem2 = Factory.create :rubygem
    Factory.create :version, number: '1.0.0', rubygem_id: @gem.id
    v = Factory.build :version, number: '1.0.0', rubygem_id: gem2.id
    v.save.should be_true
  end

  it 'should not allow a version without a number' do
    v = Factory.build :version, number: nil, rubygem: @gem
    v.save.should be_false
  end

  it 'should not allow a version with an empty number' do
    v = Factory.build :version, number: '', rubygem: @gem
    v.save.should be_false
  end
  
  it 'should not allow a version without a rubygem id' do
    v = Factory.build :version, rubygem: nil
    v.save.should be_false
  end
end
