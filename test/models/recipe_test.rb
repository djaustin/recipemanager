require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "Daniel", email: "daniel@example.com")
    @recipe = @chef.recipes.new(name:"Chicken Parm", summary:"This is the best chicken parm recipe ever",
                              description: "heat oil, add onions, add tomato sauce, add chikcen, cook for 20 mins", chef_id: 1)
  end
  
  
  test "recipe should be valid" do
    assert @recipe.valid?, "Recipe is not correctly validated"
  end
 

  # TEST NAME VALIDATION
  test "name should be present" do
    @recipe.name = nil
    assert_not @recipe.valid?, "Name presence is not validated"
  end

  test "name should be 100 or less characters" do
    @recipe.name = "x" * 101
    assert_not @recipe.valid?, "name maximum length is not correctly validated"
  end

  test "name should be at least 5 characters" do
    @recipe.name = "x" * 4
    assert_not @recipe.valid?, "name minimum length is not correctly validated"
  end

  # TEST SUMMARY VALIDATION
  test "summary should be present" do
    @recipe.summary = nil
    assert_not @recipe.valid?, "summary presence is not correcty validated"
  end

  test "summary should be no more than 150 characters" do 
    @recipe.summary = "x" * 151
    assert_not @recipe.valid?, "summary maximum length is not correctly validated"
  end

  test "summary should be at least 5 characters" do
    @recipe.summary = "x" * 4
    assert_not @recipe.valid?, "summary minimum length is not correctly validated"
  end

  # TEST DESCRIPTION VALIDATION
  test "description should be present" do
    @recipe.description = nil
    assert_not @recipe.valid?, "description presence is not correctly validated"
  end

  test "description should be at least 20 characters" do
    @recipe.description = "x" * 19
    assert_not @recipe.valid?, "description minimum length is not correctly validated"
  end

  test "description should be no more than 500 characters" do
     @recipe.description = "x" * 501
    assert_not @recipe.valid?, "description maximum length is not correctly validated"
  end

  # TEST RELATION VALIDATIONS
  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?, "chef ID presence is not correctly validated"
  end

end
