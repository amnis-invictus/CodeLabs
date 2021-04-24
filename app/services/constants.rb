class Constants
  class << self
    def as_json *_args
      {
        log_types: Log.types,
        problem_translation_languages: ProblemTranslation.languages,
        result_statuses: Result.statuses,
        submission_test_states: Submission.test_states,
        submission_test_results: Submission.test_results,
        tag_translation_languages: TagTranslation.languages,
      }
    end
  end
end
