class User < ActiveRecord::Base
  validates :name, length: { maximum: 5, too_long: "%{count} characters is the maximum allowed so there" }
  validates :email, presence: { message: "obviously should be present" }, length: { minimum: 5 }
  validate :real_email

  def real_email
    unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors.add(:email, 'Invalid format')
    end
  end

end
