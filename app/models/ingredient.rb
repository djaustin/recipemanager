class Ingredient < ActiveRecord::Base
	has_many :recipe_ingredients, :dependent => :destroy
	has_many :recipes, :through => :recipe_ingredients

	validates :name, presence: true, uniqueness: {case_sensitive: false}
end
