require 'rails_helper'

RSpec.describe StandingRedisStore do
  subject { described_class.new :user_id, :problem_id }

  it { expect(subject.instance_variable_get :@key).to eq('user_id_problem_id') }

  context do
    let(:key) { subject.instance_variable_get :@key }

    after { $redis_standings.del key }

    describe '#get' do
      context do
        before { expect(subject).to receive(:score_from_database).and_return(20) }

        its(:get) { should eq('20') }
      end

      context do
        before { $redis_standings.set key, 50 }

        before { expect(subject).to_not receive(:score_from_database) }

        its(:get) { should eq('50') }
      end
    end

    describe '#update_if_exists' do
      subject { described_class.new :user_id, :problem_id, 100 }

      context do
        before { subject.update_if_exists }

        it { expect($redis_standings.get key).to be_nil }
      end

      context do
        before { $redis_standings.set key, 50 }

        before { subject.update_if_exists }

        it { expect($redis_standings.get key).to eq('100') }
      end
    end

    describe '#score_from_database' do
      let(:params) { { user_id: :user_id, problem_id: :problem_id, test_state: :done, test_result: :ok } }

      before do
        #
        # Submission.select(:score).order(created_at: :desc).find_by(params) -> submission
        #
        expect(Submission).to receive(:select).with(:score) do
          double.tap do |a|
            expect(a).to receive(:order).with(created_at: :desc) do
              double.tap { |b| expect(b).to receive(:find_by).with(params).and_return(submission) }
            end
          end
        end
      end

      context do
        let(:submission) { double score: 90 }

        its(:score_from_database) { should eq 90 }
      end

      context do
        let(:submission) { nil }

        its(:score_from_database) { should be_nil }
      end
    end
  end

  describe '.get' do
    it do
      #
      # described_class.new(:user_id, :problem_id).get
      #
      expect(described_class).to receive(:new).with(:user_id, :problem_id) do
        double.tap { |a| expect(a).to receive(:get) }
      end
    end

    after { described_class.get :user_id, :problem_id }
  end

  describe '.update_if_exists' do
    it do
      #
      # described_class.new(:user_id, :problem_id, 55).update_if_exists
      #
      expect(described_class).to receive(:new).with(:user_id, :problem_id, 55) do
        double.tap { |a| expect(a).to receive(:update_if_exists) }
      end
    end

    after { described_class.update_if_exists :user_id, :problem_id, 55 }
  end
end
