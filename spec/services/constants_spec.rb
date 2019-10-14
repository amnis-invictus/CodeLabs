require 'rails_helper'

RSpec.describe Constants do
  subject { described_class }

  its :as_json do
    should eq \
      log_types: { 'source' => 0, 'checker' => 1 },
      problem_translation_languages: { 'ru' => 0, 'en' => 1, 'uk' => 2 },
      result_statuses: {
        'ok' => 0,
        'wrong_answer' => 1,
        'presentation_error' => 2,
        'fail' => 3,
        'dirt' => 4,
        'points' => 5,
        'bad_test' => 6,
        'unexpected_eof' => 8,
        'runtime_error' => 10,
        'memory_limit_exceded' => 14,
        'time_limit_exceded' => 15,
        'partilly_correct' => 16
      },
      submission_test_states: { 'pending' => 0, 'in_progress' => 1, 'done' => 2, 'failed' => 3 },
      submission_test_results: { 'ok' => 0, 'compiler_error' => 1 },
      tag_translation_languages: { 'ru' => 0, 'en' => 1, 'uk' => 2 }
  end
end
