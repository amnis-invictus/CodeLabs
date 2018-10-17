require 'rails_helper'

RSpec.describe SubmissionsController, type: :controller do
  it_behaves_like :index, anonymous: true

  it_behaves_like :index, anonymous: true, params: { problem_id: 7 }

  it_behaves_like :show

  it_behaves_like :new, params: { problem_id: 7 }

  it_behaves_like :create, params: { problem_id: 7 } do
    let(:resource) { stub_model Submission }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :new } }
  end

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 41) }

      before do
        #
        # subject.submissions.order(created_at: :desc).page(params[:page]) -> :collection
        #
        expect(subject).to receive_message_chain(:submissions, :order).with(created_at: :desc) do
          double.tap { |a| expect(a).to receive(:page).with(41).and_return(:collection) }
        end
      end

      its(:collection) { should eq :collection }
    end
  end

  describe '#submissions' do
    before { allow(subject).to receive(:parent).and_return(parent) }

    context do
      let(:parent) { double submissions: :submissions }

      its(:submissions) { should eq :submissions }
    end

    context do
      let(:parent) { nil }

      its(:submissions) { should eq Submission.all }
    end
  end

  describe '#parent' do
    context do
      before { subject.instance_variable_set :@parent, :parent }

      its(:parent) { should eq :parent }
    end

    context do
      before { allow(subject).to receive(:params).and_return(problem_id: 89) }

      before { expect(Problem).to receive(:find).with(89).and_return(:parent) }

      its(:parent) { should eq :parent }
    end

    context do
      before { allow(subject).to receive(:params).and_return(group_id: 89) }

      before { expect(Group).to receive(:find).with(89).and_return(:parent) }

      its(:parent) { should eq :parent }
    end

    context do
      before { allow(subject).to receive(:params).and_return(user_id: 89) }

      before { expect(User).to receive(:find).with(89).and_return(:parent) }

      its(:parent) { should eq :parent }
    end
  end

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(id: 74) }

      before do
        #
        # Submission.find(params[:id]).decorate -> :resource
        #
        expect(Submission).to receive(:find).with(74) do
          double.tap { |a| expect(a).to receive(:decorate).and_return(:resource) }
        end
      end

      its(:resource) { should eq :resource }
    end
  end

  describe '#resource_params' do
    let(:params) { acp submission: { compiler_id: '128', source: '' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(subject).to receive(:current_user).and_return(:current_user) }

    its(:resource_params) { should eq params[:submission].permit!.merge(user: :current_user) }
  end

  describe '#initialize_resource' do
    before { expect(subject).to receive_message_chain(:parent, :submissions, :new).and_return(:resource) }

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before do
      expect(subject).to receive_message_chain(:parent, :submissions, :new).with(:resource_params).and_return(:resource)
    end

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
