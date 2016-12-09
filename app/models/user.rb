# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  session_token   :string
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token
  attr_reader :password

  has_many :subs,
  primary_key: :id,
  foreign_key: :mod_id,
  class_name: :Sub

  has_many :posts,
  foreign_key: :author_id

  def generate_session_token
    return SecureRandom.urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    bc = BCrypt::Password.new(self.password_digest)
    bc.is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    return self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      return user
    else
      return nil
    end
  end

end
