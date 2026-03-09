require 'rails_helper'

RSpec.describe 'MySQL connectivity', type: :smoke do
  it 'responds to a basic query' do
    result = ActiveRecord::Base.connection.execute('SELECT 1 AS result')
    expect(result.first.first).to eq(1)
  end

  it 'can write and read a record' do
    user = create(:user)
    expect(User.find(user.id).email).to eq(user.email)
  end
end
