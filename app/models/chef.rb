class Chef < ActiveRecord::Base
	has_many :recipes
	has_many :likes

	VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :chefname, presence: true, length: {minimum: 2, maximum: 40}
	validates :email, format: {with: VALID_EMAIL_REGEX}, presence: true, uniqueness: {case_sensitive: false} # Checks for uniqueness with special parameter
end
