class Style < ActiveRecord::Base
	has_many :recipe_styles, :dependent => :destroy
	has_many :recipes, :through => :recipe_styles

	validates :name, presence: true, uniqueness: {case_sensitive: false}
end
