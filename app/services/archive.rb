class Archive
  include ActiveModel::Validations

  attr_accessor :file, :channel_id, :user

  validates :file, :channel_id, presence: true

  validate :file_must_be_valid

  def initialize params={}
    @file = params[:file]

    @channel_id = params[:channel_id]

    @user = params[:user]
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

  def file_must_be_valid
    return if file.is_a?(ActionDispatch::Http::UploadedFile) && file.content_type == 'application/zip'
    
    errors.add :file, :invalid
  end
end
