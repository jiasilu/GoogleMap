#require 'bcrypt'
require 'digest/sha1'
class User < ActiveRecord::Base
  # users.password_hash in the database is a :string
#  include BCrypt
#  validates :name, presence: true, uniqueness: true
#  has_secure_password
  attr_accessor :password, :password_confirmation
  # Password length should between 4-40 bytes
  validates_length_of :password, :within => 4..40
  # Confirmation must be identical with the password
  validates_confirmation_of :password
  # Validate the presence of the information
  validates_presence_of :username, :email, :password
  # Username and email must be unique
  validates_uniqueness_of :username, :email
  # Email format must be right
  validates_format_of :email,
    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  # Password generation
  before_create :initialize_salt, :encrypt_password
  
  # Generate new password
  def encrypt(string)
    generate_hash("--#{password_salt}--#{string}--")
  end
  
  protected
  def generate_hash(string)
    Digest::SHA1.hexdigest(string)
  end
  
  def initialize_salt
   if new_record?
      self.password_salt = generate_hash("--#{Time.now.to_s}--#{email}--")
    end
  end
  
  def encrypt_password
    return if password.blank?
    self.encrypted_password = encrypt(password)
  end
  
end
