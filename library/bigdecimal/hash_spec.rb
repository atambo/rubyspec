require File.expand_path('../../../spec_helper', __FILE__)
require 'bigdecimal'

describe "Bigdecimal#hash" do
  it "ignores scale" do
    BigDecimal("2").hash.should == BigDecimal("2.0").hash
  end
end
