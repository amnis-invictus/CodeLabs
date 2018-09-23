require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '#show' do
    context do
      before { expect(subject).to receive(:current_user).and_return(nil) }

      it_behaves_like :show, anonymous: true, unauthorized: true
    end

    context do
      before { expect(subject).to receive(:current_user).and_return(:current_user) }

      it { expect(subject).to receive(:redirect_to).with(:profile) }

      after { subject.show }
    end
  end
end
