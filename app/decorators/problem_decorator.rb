class ProblemDecorator < Draper::Decorator
  delegate_all

  delegate :caption, :author, :text, :technical_text, to: :translation, allow_nil: true

  def as_json *_args
    case context
    when :submission
      {
        id:,
        updated_at:,
        checker_compiler_id:,
      }
    when :api
      {
        id:,
        updated_at:,
        checker_compiler_id:,
        checker_source_url:,
        tests:,
      }
    else
      {
        id:,
        search_suggestion: h.tag.div(caption),
      }
    end
  end

  def checker_source_url
    helpers.url_for checker_source if checker_source.attached?
  end

  def translation
    super || default_translation
  end

  def language
    translation&.language&.to_sym
  end
end
