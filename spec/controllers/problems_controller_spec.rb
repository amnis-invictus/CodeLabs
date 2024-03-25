require 'rails_helper'

RSpec.describe ProblemsController, type: :controller do
  it_behaves_like :index, anonymous: true

  it_behaves_like :index, params: { tag_id: 25 }, anonymous: true

  it_behaves_like :index, params: { user_id: 25 }, anonymous: true

  it_behaves_like :show, anonymous: true

  it_behaves_like :new

  it_behaves_like :edit

  it_behaves_like :create do
    let(:resource) { stub_model Problem }

    let :success do
      lambda do
        should set_flash[:success]

        should redirect_to resource
      end
    end

    let :failure do
      lambda do
        should set_flash.now[:error]

        should render_template :new
      end
    end
  end

  it_behaves_like :update do
    let(:resource) { stub_model Problem }

    let :success do
      lambda do
        should set_flash[:success]

        should redirect_to resource
      end
    end

    let :failure do
      lambda do
        should set_flash.now[:error]

        should render_template :edit
      end
    end
  end

  it_behaves_like :destroy do
    let(:resource) { stub_model Problem }

    let(:success) { -> { should redirect_to :problems } }
  end

  describe '#resource_params' do
    let :params do
      acp problem: {
        memory_limit: '1000',
        time_limit: '256',
        real_time_limit: '5000',
        checker_compiler_id: '1',
        checker_source: '',
        private: '0',
        tag_ids: %w[1 2],
        examples_attributes: [{ id: '1', input: '', answer: '', _destroy: '' }],
        tests_attributes: [{ id: '2', num: 'b', point: '10', input: '', answer: '', _destroy: '' }],
        translations_attributes: [{
          id: '3',
          language: 'ru',
          caption: 'a problem',
          author: '@just806me',
          text: 'Just solve it',
          technical_text: '$$ f(x, z) = x^2 + z^2 $$',
          default: '1',
          _destroy: '',
        }],
      }
    end

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:problem].permit! }
  end

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 12) }

      before do
        #
        # subject.problems.includes(:user).order(:id).page(12) -> :collection
        #
        expect(subject).to receive_message_chain(:problems, :includes).with(:user) do
          double.tap do |a|
            expect(a).to receive(:order).with(:id) do
              double.tap { |b| expect(b).to receive(:page).with(12).and_return(:collection) }
            end
          end
        end
      end

      its(:collection) { should eq :collection }
    end
  end

  describe '#problems' do
    before { expect(subject).to receive(:params).and_return(params) }

    context do
      let(:params) { acp user_id: '1', tag_id: '2', contest_id: '3', query: 'query' }

      its :problems do
        by_translation = ProblemTranslation.where('caption ILIKE ?', '%query%').select(:problem_id)
        conditions = { user_id: 1, problems_tags: { tag_id: 2 }, sharings: { contest_id: 3 }, id: by_translation }
        should eq Problem.joins(:problems_tags, :sharings).where(conditions)
      end
    end

    context do
      let(:params) { acp({}) }

      its(:problems) { should eq Problem.all }
    end
  end

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(id: 28) }

      before do
        expect(Problem).to receive(:find).with(28) do
          double.tap { |a| expect(a).to receive(:decorate).and_return(:resource) }
        end
      end

      its(:resource) { should eq :resource }
    end
  end

  describe '#initialize_resource' do
    before { expect(subject).to receive_message_chain(:current_user, :problems, :new).and_return(:resource) }

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before do
      expect(subject).to receive_message_chain(:current_user, :problems, :new).with(:resource_params).and_return(:resource)
    end

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
