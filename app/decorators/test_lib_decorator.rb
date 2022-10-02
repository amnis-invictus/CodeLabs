class TestLibDecorator < Draper::Decorator
  delegate_all

  def as_json *_args
    { version: version, binary_url: binary_url }
  end

  def version
    VersionAdapter.array_to_string model.version
  end

  def binary_url
    helpers.full_url_for model.binary if model.binary.attached?
  end
end
