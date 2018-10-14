require 'rails_helper'

RSpec.describe InviteDecorator do
  fixtures :invites

  let(:resource) { invites(:one) }

  subject { resource.decorate }

  it { should delegate_method(:name).to(:sender).with_prefix }

  it { should delegate_method(:name).to(:receiver).with_prefix }
end
