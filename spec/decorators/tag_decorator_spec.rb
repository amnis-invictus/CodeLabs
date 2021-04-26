require 'rails_helper'

RSpec.describe TagDecorator do
  let(:resource) { stub_model Tag, id: 5, name: 'Simple Problem' }

  subject { resource.decorate }

  its(:as_json) { should eq value: 5, text: 'Simple Problem' }
end
