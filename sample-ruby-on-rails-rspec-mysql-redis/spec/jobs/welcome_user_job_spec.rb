require 'rails_helper'

RSpec.describe WelcomeUserJob, type: :job do
  include ActiveJob::TestHelper

  let(:user) { create(:user) }

  describe '#perform' do
    it 'logs a welcome message for the user' do
      allow(Rails.logger).to receive(:info) # allow ActiveJob's own lifecycle logging
      expect(Rails.logger).to receive(:info)
        .with("Welcome #{user.name}! Your account has been created.")

      described_class.perform_now(user)
    end
  end

  describe 'enqueueing' do
    it 'is queued on the default queue' do
      expect { described_class.perform_later(user) }
        .to have_enqueued_job(described_class)
        .on_queue('default')
        .with(user)
    end
  end
end
