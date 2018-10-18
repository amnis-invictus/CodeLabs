require 'rails_helper'

RSpec.describe Worker, type: :model do
  it { should validate_presence_of :name }

  it { should validate_presence_of :ips }

  it { should validate_presence_of :status }

  it { should validate_presence_of :api_type }

  it { should validate_presence_of :alive_at }

  it { should validate_presence_of :api_version }

  it { should validate_numericality_of(:api_version).only_integer }

  it { should define_enum_for(:api_type).with(HTTP: 0, WS: 1) }

  it { should define_enum_for(:status).with(disabled: 0, ok: 1, failed: 2, stale: 3, stopped: 4) }

  it { should delegate_method(:as_json).to(:decorate) }
end
