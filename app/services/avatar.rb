class Avatar
  include ActiveModel::Validations

  include Draper::Decoratable

  attr_accessor :user, :file

  validates :user, :file, presence: true

  validate :blob_must_be_variable, :blob_size_must_not_be_greater_that_2_megabytes

  delegate :avatar, to: :user, allow_nil: true

  delegate :attached?, to: :avatar, allow_nil: true

  delegate :as_json, :url, to: :decorate

  def initialize params = {}
    @user, @file = params.values_at :user, :file
  end

  def save
    avatar.attach blob if valid?
  end

  def destroy
    avatar&.purge_later
  end

  private

  def blob
    @blob ||= ActiveStorage::Blob.build_after_upload \
      io: file.open, filename: file.original_filename, content_type: file.content_type
  end

  def blob_must_be_variable
    return if file.blank?

    errors.add :file, :invalid unless blob.variable?
  end

  def blob_size_must_not_be_greater_that_2_megabytes
    return if file.blank?

    errors.add :file, :too_long, count: 2.megabytes if blob.byte_size > 2.megabytes
  end
end
