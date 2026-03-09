require 'rails_helper'

RSpec.describe 'Redis connectivity', type: :smoke do
  let(:redis) { Redis.new(url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0')) }

  after { redis.del('smoke_test_key') }

  it 'responds to PING' do
    expect(redis.ping).to eq('PONG')
  end

  it 'can write and read a value' do
    redis.set('smoke_test_key', 'ok', ex: 30)
    expect(redis.get('smoke_test_key')).to eq('ok')
  end
end
