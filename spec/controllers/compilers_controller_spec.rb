require 'rails_helper'

RSpec.describe CompilersController, type: :controller do
  it_behaves_like :index

  it_behaves_like :new

  it_behaves_like :edit

  it_behaves_like :create do
    let(:resource) { double }

    let :success do
      lambda do
        should set_flash[:success]

        should redirect_to :compilers
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
    let(:resource) { double }

    let :success do
      lambda do
        should set_flash.now[:success]

        should render_template :edit
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
    let(:success) { -> { should redirect_to :compilers } }
  end

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 10) }

      before do
        #
        # Compiler.order(:id).page(params[:page]) -> :collection
        #
        expect(Compiler).to receive(:order).with(:id) do
          double.tap { |a| expect(a).to receive(:page).with(10).and_return(:collection) }
        end
      end

      its(:collection) { should eq :collection }
    end
  end

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(id: 28) }

      before { expect(Compiler).to receive(:find).with(28).and_return(:resource) }

      its(:resource) { should eq :resource }
    end
  end

  describe '#resource_params' do
    let :params do
      acp compiler: {
        name: 'gcc',
        version: '6.4',
        time_a: '100',
        time_b: '1',
        memory_a: '0',
        memory_b: '3',
        status: 'public',
        config: '<xml>data</xml>',
      }
    end

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:compiler].permit! }
  end

  describe '#initialize_resource' do
    before { expect(Compiler).to receive(:new).and_return(:resource) }

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(Compiler).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
