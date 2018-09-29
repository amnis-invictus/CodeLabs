require 'rails_helper'

RSpec.describe ProblemsController, type: :controller do
  it_behaves_like :index, anonymous: true

  it_behaves_like :show, anonymous: true

  it_behaves_like :new

  pending '#create'

  pending '#resource_params'

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 12) }

      before { expect(subject).to receive_message_chain(:parent, :problems, :page).with(12).and_return(:collection) }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 12) }

      before { expect(subject).to receive(:parent).and_return(nil) }

      before { expect(Problem).to receive_message_chain(:all, :page).with(12).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end

  describe '#parent' do
    context do
      before { expect(subject).to receive(:params).and_return(tag_id: 5) }

      before { subject.instance_variable_set :@parent, :parent }

      its(:parent) { should eq :parent }
    end

    context do
      before { expect(subject).to receive(:params).and_return(tag_id: 5).twice }

      before { expect(Tag).to receive(:find).with(5).and_return(:parent) }

      its(:parent) { should eq :parent }
    end

    context do
      before { expect(subject).to receive(:params).and_return({}) }

      its(:parent) { should be_nil }
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
    before { expect(Problem).to receive(:new).and_return(:resource) }

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(Problem).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
