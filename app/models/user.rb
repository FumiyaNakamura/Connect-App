class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255},
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false}
    validates :password, presence: true, length: { minimum: 6 }
    validate :picture_size
    has_secure_password
    mount_uploader :image, ImageUploader
    
    private
    
      def picture_size
        if picture_size > 5.megabytes
             errors.add(:image, "should be less than 5MB")
        end
      end
    
    
end
