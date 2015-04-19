class Recipe < ActiveRecord::Base
  belongs_to :chef
  validates :name, presence: true, length: {minimum: 5, maximum: 100}
  validates :summary, presence: true, length: {minimum: 5, maximum: 150}
  validates :description, presence: true, length: {minimum: 20, maximum: 500}
  validates :chef_id, presence: true

  mount_uploader :image, ImageUploader
  validate :image_size

  private 
  	def image_size 
  		if image.size > 5.megabytes 
  			errors.add(:image, "should be less than 5MB")
  		end
  	end
end
