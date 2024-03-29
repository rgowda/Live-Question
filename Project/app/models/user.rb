require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :admin

  has_many :microposts, :dependent => :destroy

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
            :length => {:maximum => 50}
  validates :email, :presence => true,
            :format => {:with => email_regex},
            :uniqueness => {:case_sensitive => false}
  validates :password, :presence => true,
            :confirmation => true,
            :length => {:within => 6..40}

  before_save :encrypt_password

  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def feed
    # This is preliminary. See Chapter 12 for the full implementation.
    Micropost.where("user_id = ? and micropost_id IS NULL", id).order("activity DESC")
  end

  def feedAll
    Micropost.where("micropost_id IS NULL").order("activity DESC")
  end
  def feedmicropostreport
    Micropost.order("user_id , no_of_vote DESC")
  end
  def feeduserreport
    User.order("id")
  end

  private

  def encrypt_password
    self.salt = make_salt() unless has_password?(password)
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end
