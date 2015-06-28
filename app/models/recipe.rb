class Recipe < ActiveRecord::Base
  belongs_to :chef
  has_many :likes, :dependent => :destroy

  has_many :recipe_styles, :dependent => :destroy
  has_many :styles, :through => :recipe_styles
  
  has_many :recipe_ingredients, :dependent => :destroy
  has_many :ingredients, :through => :recipe_ingredients

  validates :name, presence: true, length: {minimum: 5, maximum: 100}
  validates :summary, presence: true, length: {minimum: 5, maximum: 150}
  validates :description, presence: true, length: {minimum: 20, maximum: 500}
  validates :chef_id, presence: true
  default_scope {order(updated_at: :desc)}

  mount_uploader :image, ImageUploader
  validate :image_size

  def like_count 
    self.likes.where(like: true).size
  end

  def dislike_count
    self.likes.where(like: false).size
  end

  private 
  	def image_size 
  		if image.size > 5.megabytes 
  			errors.add(:image, "should be less than 5MB")
  		end
  	end
end
