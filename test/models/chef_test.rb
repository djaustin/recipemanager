require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
	def setup 
  	@chef = Chef.new(chefname: "Dan", email: "dan@example.com")
  end

  test "chef should be valid" do
  	assert @chef.valid?
  end

  test "chefname should be present" do
  	@chef.chefname = nil
  	assert @chef.invalid?, "chefname presence is not correctly validated"
  end

  test "chefname should be at least 2 characters" do
  	@chef.chefname = "x"
  	assert @chef.invalid?, "chefname minimum length is not correctly validated"
  end

  test "chefname should be no more than 40 characters" do
  	@chef.chefname = "x" * 41
  	assert @chef.invalid?, "chefname maximum length is not correctly validated"

  	@chef.chefname = "x" * 40
  	assert @chef.valid?, "chefname maximum length is not correctly validated"
  end

  test "email should be present" do
  	@chef.email = nil
  	assert @chef.invalid?, "chef email presence is not correctly validated"
  end

  test "email should be unique" do
  	dup_chef = @chef.dup

  	dup_chef.save

  	assert @chef.invalid?
  end

  test "email validation should accept valid addresses" do 
  	valid_addresses = ["user@example.com", "TDD-S_S@hello.org.uk"]

  	valid_addresses.each do |va|
  		@chef.email = va
  		assert @chef.valid?, "#{va} should be valid"
  	end

  end

  test "email validation should reject invalid addresses" do
  	invalid_addresses = ["test", "test.com"]

  	invalid_addresses.each do |ia|
  		@chef.email = ia
  		assert @chef.invalid?, "#{ia.inspect} should be invalid"
  	end
  end
end
