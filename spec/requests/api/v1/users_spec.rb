require 'rails_helper'

RSpec.describe 'API::V1::Users', type: :request do
  let!(:users) { create_list(:user, 5) }

  before do
    users.each do |user|
      create_list(:comment, 3, user: user)
    end
  end

  describe 'GET /api/v1/users' do
    it 'returns list of users with their comments' do
      get '/api/v1/users', headers: headers

      expect(response).to have_http_status(200)
      expect(json_response['users'].size).to eq(5)
      expect(json_response['users'].first).to include('id', 'username', 'email')
    end

    it 'respects pagination parameters' do
      get '/api/v1/users', params: { page: 2, per_page: 2 }, headers: headers

      expect(response).to have_http_status(200)
      expect(json_response['users'].size).to eq(2)
      expect(json_response['page']).to eq(2)
      expect(json_response['per_page']).to eq(2)
    end
  end

  describe 'GET /api/v1/users/:user_id/comments' do
    let(:user) { users.first }

    it 'returns user comments with pagination' do
      get "/api/v1/users/#{user.id}/comments", headers: headers

      expect(response).to have_http_status(200)
      expect(json_response['comments'].size).to eq(3)
      expect(json_response['user_id']).to eq(user.id)
      expect(json_response['comments'].first).to include('id', 'content')
    end

    it 'respects pagination parameters' do
      get "/api/v1/users/#{user.id}/comments",
          params: { page: 1, per_page: 1 },
          headers: headers

      expect(response).to have_http_status(200)
      expect(json_response['comments'].size).to eq(1)
      expect(json_response['page']).to eq(1)
      expect(json_response['per_page']).to eq(1)
    end

    it 'orders comments by created_at desc' do
      old_comment = create(:comment, user: user, created_at: 1.day.ago)
      get "/api/v1/users/#{user.id}/comments", headers: headers

      expect(json_response['comments'].first['id']).not_to eq(old_comment.id)
    end

    context 'when user does not exist' do
      it 'returns not found error' do
        get '/api/v1/users/999/comments', headers: headers
        expect(response).to have_http_status(404)
      end
    end
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end
