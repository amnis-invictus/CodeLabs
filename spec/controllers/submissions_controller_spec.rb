require 'rails_helper'

RSpec.describe SubmissionsController, type: :controller do
  it_behaves_like :show

  it_behaves_like :index, anonymous: true

  it_behaves_like :index, anonymous: true, params: { problem_id: 7 }

  it_behaves_like :index, anonymous: true, params: { contest_id: 7 }

  it_behaves_like :index, anonymous: true, params: { user_id: 7 }

  it_behaves_like :index, anonymous: true, params: { user_id: 7, problem_id: 7 }

  it_behaves_like :create, params: { problem_id: 7 } do
    let(:resource) { stub_model Submission }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :new } }
  end

  it_behaves_like :destroy do
    let(:success) { -> { should redirect_to :submissions } }
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
        # subject.submissions.includes(:compiler, :user, problem: :user).
        #   order(created_at: :desc).page(params[:page]) -> :collection
        #
        expect(subject).to receive_message_chain(:submissions, :includes).with(:compiler, :user, problem: :user) do
          double.tap do |a|
            expect(a).to receive(:order).with(created_at: :desc) do
              double.tap { |b| expect(b).to receive(:page).with(41).and_return(:collection) }
            end
          end
        end
      end

      its(:collection) { should eq :collection }
    end
  end

  describe '#submissions' do
    before { allow(subject).to receive(:params).and_return(params) }

    context do
      let(:params) { acp contest_id: 1, problem_id: 2, user_id: 3 }

      its :submissions do
        conditions = { memberships: { contest_id: 1 }, problem_id: 2, user_id: 3 }
        should eq Submission.joins(user: :accepted_memberships).where(conditions)
      end
    end

    context do
      let(:params) { acp({}) }

      its(:submissions) { should eq Submission.all }
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

  describe '#build_resource' do
    let(:problem) { stub_model Problem }

    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(subject).to receive(:params).and_return(problem_id: 7) }

    before { expect(Problem).to receive(:find).with(7).and_return(problem) }

    before { expect(problem).to receive_message_chain(:submissions, :new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
