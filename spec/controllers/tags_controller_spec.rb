require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  it_behaves_like :index, anonymous: true

  it_behaves_like :index, anonymous: true, format: :json

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection , :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 51) }

      before do
        expect(Tag).to receive(:order).with(problems_count: :desc) do
          double.tap { |a| expect(a).to receive(:page).with(51).and_return(:collection) }
        end
      end

      its(:collection) { should eq :collection }
    end
  end
end
