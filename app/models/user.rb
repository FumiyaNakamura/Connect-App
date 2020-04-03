class User < ApplicationRecord
    has_many:posts
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255},
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false}
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    validate :image_size
    has_secure_password
    mount_uploader :image, ImageUploader
    
    private
    
      def image_size
        if image.size > 5.megabytes
             errors.add(:image, "should be less than 5MB")
        end
      end
    
    
end
