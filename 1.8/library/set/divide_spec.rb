require File.dirname(__FILE__) + '/../../spec_helper'
require 'set'

describe "Set#divide" do
  it "divides self into a set of subsets based on the blocks return values" do
    set = Set["one", "two", "three", "four", "five"].divide { |x| x.length }
    set.should == Set[Set["one", "two"], Set["four", "five"], Set["three"]]
  end
  
  it "yields each Object to the block" do
    ret = []
    Set["one", "two", "three", "four", "five"].divide { |x| ret << x }
    ret.sort.should == ["one", "two", "three", "four", "five"].sort
  end
  
  # BUG: Does not raise a LocalJumpError, but a NoMethodError
  #
  # it "raises a LocalJumpError when not passed a block" do
  #   lambda { Set[1].divide }.should raise_error(LocalJumpError)
  # end
end

describe "Set#divide when passed a block with an arity of 2" do
  it "divides self into a set of subsets based on the blocks return values" do
    set = Set[1, 3, 4, 6, 9, 10, 11].divide { |x, y| (x - y).abs == 1 }
    set.should == Set[Set[1], Set[11, 9, 10], Set[3, 4], Set[6]]
  end
  
  it "yields each two Object to the block" do
    ret = []
    Set[1, 2].divide { |x, y| ret << [x, y] }
    ret.should == [[1, 1], [1, 2], [2, 1], [2, 2]]
  end
end
