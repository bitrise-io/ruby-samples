require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:users) { create_list(:user, 3) }
  let(:user)   { users.first }

  describe 'GET /users' do
    before { get '/users' }

    it 'returns HTTP 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all users' do
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /users/:id' do
    context 'when the user exists' do
      before { get "/users/#{user.id}" }

      it 'returns HTTP 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct user' do
        expect(JSON.parse(response.body)['id']).to eq(user.id)
      end
    end

    context 'when the user does not exist' do
      before { get '/users/0' }

      it 'returns HTTP 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        expect(JSON.parse(response.body)['error']).to eq('User not found')
      end
    end
  end

  describe 'POST /users' do
    let(:valid_params)   { { user: { name: 'Alice', email: 'alice@example.com', age: 30 } } }
    let(:invalid_params) { { user: { name: '', email: 'bad', age: -5 } } }

    context 'with valid parameters' do
      it 'creates a new user and returns HTTP 201' do
        expect {
          post '/users', params: valid_params, as: :json
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['email']).to eq('alice@example.com')
      end
    end

    context 'with invalid parameters' do
      before { post '/users', params: invalid_params, as: :json }

      it 'returns HTTP 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns validation errors' do
        errors = JSON.parse(response.body)['errors']
        expect(errors).to be_present
      end
    end
  end

  describe 'PATCH /users/:id' do
    context 'with valid parameters' do
      before { patch "/users/#{user.id}", params: { user: { name: 'Updated Name' } }, as: :json }

      it 'returns HTTP 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the user' do
        expect(JSON.parse(response.body)['name']).to eq('Updated Name')
      end
    end

    context 'with invalid parameters' do
      before { patch "/users/#{user.id}", params: { user: { email: 'not-an-email' } }, as: :json }

      it 'returns HTTP 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the user does not exist' do
      before { patch '/users/0', params: { user: { name: 'X' } }, as: :json }

      it 'returns HTTP 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /users/:id' do
    context 'when the user exists' do
      it 'deletes the user and returns HTTP 204' do
        expect {
          delete "/users/#{user.id}"
        }.to change(User, :count).by(-1)

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the user does not exist' do
      before { delete '/users/0' }

      it 'returns HTTP 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
