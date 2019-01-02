class Session
  include ActiveModel::Validations

  attr_accessor :email, :password

  validates :email, :password, presence: true

  validate :user_must_be_present, :password_must_pass_authentication

  delegate :destroy, to: :auth_token

  def initialize params = {}
    @email, @password, @auth_token = params.values_at :email, :password, :auth_token
  end

  def to_key; end

  def persisted?; false; end

  def save
    valid? ? auth_token.save : false
  end

  def user
    @user ||= User.find_by email: email
  end

  def auth_token
    @auth_token ||= user.auth_tokens.build
  end

  private

  def user_must_be_present
    return if email.blank?

    errors.add :email, :invalid if user.blank?
  end

  def password_must_pass_authentication
    return if password.blank? || user.blank?

    errors.add :password, :invalid unless user.authenticate password
  end
end
