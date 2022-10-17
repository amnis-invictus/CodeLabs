require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  subject { helper }

  fixtures :users

  its(:language_select_options) { should eq [['Русский', :ru], ['English', :en], ['Українська', :uk]] }

  describe '#visible_compilers' do
    context do
      before { allow(subject).to receive(:current_user).and_return(users :one) }

      its(:visible_compilers) { should eq Compiler.status_public }
    end

    context do
      before { allow(subject).to receive(:current_user).and_return(users :two) }

      its(:visible_compilers) { should eq Compiler.all }
    end
  end

  describe '#checker_compilers' do
    context do
      before { allow(subject).to receive(:current_user).and_return(users :one) }

      its(:checker_compilers) { should eq Compiler.where.not status: :in_test }
    end

    context do
      before { allow(subject).to receive(:current_user).and_return(users :two) }

      its(:checker_compilers) { should eq Compiler.all }
    end
  end

  describe '#sanitize_for_problem' do
    let(:tags) { %w[b br em i u p span strong sub sup table tbody td th thead tr img ul ol li] }

    let(:attributes) { %w[class src alt] }

    before { expect(subject).to receive(:sanitize).with(:text, tags: tags, attributes: attributes).and_return(:sanitized) }

    it { expect(subject.sanitize_for_problem :text).to eq(:sanitized) }
  end
end
