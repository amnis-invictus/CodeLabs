class ByteSizeValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    return unless value.attached?

    record.errors.add attribute, :too_long, count: options[:maximum] if value.byte_size > options[:maximum]
  end
end
