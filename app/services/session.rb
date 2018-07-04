class Session
  include ActiveModel::Validations

  attr_reader :email, :password

  validates :email, presence: true

  validates :password, presence: true

  validate :user_must_be_present

  validate :password_must_pass_authentication

  delegate :destroy, to: :auth_token

  def initialize params={}
    @email, @password, @auth_token, @redirect = params.values_at :email, :password, :auth_token, :redirect
  end

  def to_key; end

  def persisted?
    false
  end

  def save
    return false unless valid?

    auth_token.save
  end

  def auth_token
    @auth_token ||= user.auth_tokens.build
  end

  def user
    @user ||= User.find_by email: email
  end

  def redirect
    @redirect.present? ? @redirect : :profile
  end

  private
  def user_must_be_present
    return if email.blank?

    errors.add :email, :invalid if user.blank?
  end

  def password_must_pass_authentication
    return if password.blank? || email.blank? || user.blank?

    errors.add :password, :invalid unless user.authenticate password
  end
end
