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
  before_create :initialize_salt, :encrypt_password, :initialize_activation_token
  
  # Generate new password
  def encrypt(string)
    generate_hash("--#{password_salt}--#{string}--")
  end
  
  # Check the account activation
  def activated?
    # When activation_token = nil, it means already activated
    activation_token.nil?
  end
  
  # Activate account
  def email_confirm!
    update_attributes(:activation_token => nil, :activation_at => Time.now)
  end
  
  # Validate the password with the email
  def self.authenticate(email, password)
    account = email.to_s
    user = find(:first, :conditions => ['email = ?', account])
    user && user.authenticated?(password) ? user : nil
  end

  #Validate the password
  def authenticated?(password)
    encrypted_password == encrypt(password)
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
  
  #generate token
  def generate_token
    encrypt(Time.now.to_s.split(//).sort_by {rand}.join)
  end
  
  #generate activation token
  def initialize_activation_token
    if new_record?
      self.activation_token = generate_token
    end
  end
  
end
