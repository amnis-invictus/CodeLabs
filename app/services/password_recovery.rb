class PasswordRecovery
  include ActiveModel::Validations

  attr_accessor :email

  validate :user_must_be_present

  validates :email, presence: true

  def initialize params = {}
    @email = params[:email]
  end

  def to_key; end

  def persisted?; false; end

  def save
    return unless valid?

    user.update! password_recovery_token: SecureRandom.uuid

    PasswordRecoveryMailer.email(user).deliver_later
  end

  private

  def user
    @user ||= User.find_by 'lower(email) = lower(?)', email
  end

  def user_must_be_present
    errors.add :email, :invalid if email.present? && user.blank?
  end
end
