class Archive
  include ActiveModel::Validations

  attr_accessor :user, :file, :channel_id

  validates :user, :file, :channel_id, presence: true

  def initialize params = {}
    @user, @file, @channel_id = params.values_at :user, :file, :channel_id
  end

  def to_key; end

  def persisted?; false; end

  def to_model; self; end

  def save
    return false unless valid?

    FileUtils.copy file.path, filename

    ProcessProblemArchiveJob.perform_later user, filename, channel_id

    true
  end

  private

  def filename
    @filename ||= File.join Dir.tmpdir, SecureRandom.uuid
  end
end
