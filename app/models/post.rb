class Post < ApplicationRecord
  belongs_to :user
  default_scope -> {  order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence:true, length: { maximum: 300 }
  validate :image_size
  mount_uploader :image, ImageUploader
  
  private
    
      def image_size
        if image.size > 5.megabytes
             errors.add(:image, "should be less than 5MB")
        end
      end
end
