require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET /users/:id' do
    before do
      auth_headers = {"Authorization" => "Bearer #{user.token}"}
      request.headers.merge!(auth_headers)
      get :show, params: { id: user_id }
    end
     
    let(:user) { User.create(email: "example@gmail.com", name: "test", password: "12345678", token: SecureRandom.hex) }
    let(:user_id) {user.id}

    context 'when the record exists' do
      it 'returns the user' do
        json = JSON.parse(response.body)
        expect(json.keys).to match_array(["id", "email", "name","avatar"])

        expect(json["email"]).to eql user.email
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 10 }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"User not found\"}")
      end
    end
  end

  describe 'POST /users' do

    context 'when the request is valid' do
      before do
        post :create, params: { email: "example@gmail.com", name: "test", password: "12345678" }
      end
      it 'creates user' do
        json = JSON.parse(response.body)
        expect(json['email']).to eq('example@gmail.com')
        expect(json['name']).to eq('test')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before do
        post :create, params: { name: 'test', password: "12345678" }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match("{\"errors\":[\"Email can't be blank\",\"Email is invalid\"]}")
      end
    end
  end

  describe 'PUT /users/:id' do
    before do
      auth_headers = {"Authorization" => "Bearer #{user.token}"}
      request.headers.merge!(auth_headers)
      put :update, params: {id: user.id, email: "exampletwo@gmail.com"}
    end
    let(:user) { User.create(email: "example@gmail.com", name: "test", password: "12345678", token: SecureRandom.hex) }
    
    context 'when the request is valid' do
      it 'updates the record' do
        json = JSON.parse(response.body)
        expect(json['email']).to eq('exampletwo@gmail.com')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before do
        put :update, params: {id: user.id, email: "12345.mailyo"}
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match("{\"errors\":[\"Email is invalid\"]}")
      end
    end
  end

  describe 'DELETE /users/:id' do
    before do
      auth_headers = {"Authorization" => "Bearer #{user.token}"}
      request.headers.merge!(auth_headers)
      delete :destroy, params: { id: user.id }
    end

    let(:user) { User.create(email: "example@gmail.com", name: "test", password: "12345678", token: SecureRandom.hex) }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end