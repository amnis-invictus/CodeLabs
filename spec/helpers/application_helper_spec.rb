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

    before { expect(subject).to receive(:sanitize).with(:text, tags:, attributes:).and_return(:sanitized) }

    it { expect(subject.sanitize_for_problem :text).to eq(:sanitized) }
  end

  pending '#contest_visibility_select_options'

  pending '#group_visibility_select_options'

  describe '#filter_toggle' do
    before do
      locals = { param: :param, label: :label, disabled: false }
      expect(subject).to receive(:render).with(partial: 'widgets/filter/toggle', locals:).and_return(:rendered)
    end

    context do
      before { expect(subject).to receive(:t).with('.param').and_return(:label) }

      it { expect(subject.filter_toggle :param).to eq(:rendered) }
    end

    context do
      before { expect(subject).to_not receive(:t) }

      it { expect(subject.filter_toggle :param, label: :label).to eq(:rendered) }
    end
  end

  describe '#filter_dropdown' do
    before do
      locals = { form: :form, param: :param, url: '/params.json?query=%', header: :header,
                 hidden_field: 'param_id', query_field: 'param_name' }
      expect(subject).to receive(:render).with(partial: 'widgets/filter/dropdown', locals:).and_return(:rendered)
    end

    before { expect(subject).to receive(:t).with('.param_filter').and_return(:header) }

    it { expect(subject.filter_dropdown :form, :param).to eq(:rendered) }
  end
end
