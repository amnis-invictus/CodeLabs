require 'rails_helper'

RSpec.describe CompilerDecorator do
  let :resource do
    stub_model Compiler, id: 128, name: 'Visual C++', version: '14.0.12', memory_a: 1, memory_b: 0, time_a: 1, time_b: 0
  end

  subject { resource.decorate }

  its :as_json do
    should eq  id: 128, name: 'Visual C++', version: '14.0.12', memory_a: 1, memory_b: 0, time_a: 1, time_b: 0
  end
end
