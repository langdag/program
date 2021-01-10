require 'rails_helper'

RSpec.describe PartnershipsController, type: :controller do
  describe 'GET /partnership_programs' do
    before do
      auth_headers = {"Authorization" => "Bearer #{user.token}"}
      request.headers.merge!(auth_headers)
      get :get_partnerships
    end
    let(:user) { create(:user) }
    
    it 'returns partnerships' do
      json = JSON.parse(response.body)
      expect(assigns[:partnerships].size).to eq(1)
    end
    
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /partnerships/:id' do
    before do
      auth_headers = {"Authorization" => "Bearer #{user.token}"}
      request.headers.merge!(auth_headers)
      get :show, params: { id: partnership_id }
    end
     
    let(:user) { User.create(email: "example@gmail.com", name: "test", password: "12345678", token: SecureRandom.hex) }
    let(:partnership) { Partnership.create(title: "program", description: "this program is meant to be...")}
    let(:partnership_id) {partnership.id}

    context 'when the record exists' do
      it 'returns the user' do
        json = JSON.parse(response.body)
        expect(json.keys).to match_array(["id", "title", "description","files"])

        expect(json["title"]).to eql partnership.title
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:partnership_id) { 100 }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Partnership not found\"}")
      end
    end
  end

  describe 'POST /partnerships' do
    before do
        auth_headers = {"Authorization" => "Bearer #{user.token}"}
        request.headers.merge!(auth_headers)
        post :create, params: { title: "program", description: "this program is meant to be..." }
    end

    let(:user) { User.create(email: "example@gmail.com", name: "test", password: "12345678", token: SecureRandom.hex) }

    context 'when the request is valid' do

      it 'creates user' do
        json = JSON.parse(response.body)
        expect(json['title']).to eq('program')
        expect(json['description']).to eq('this program is meant to be...')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before do
        post :create, params: { description: 'this program is meant to be...' }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match("{\"errors\":[\"Title can't be blank\"]}")
      end
    end
  end

  describe 'PUT /users/:id' do
    before do
      auth_headers = {"Authorization" => "Bearer #{user.token}"}
      request.headers.merge!(auth_headers)
      put :update, params: {id: partnership.id, description: "this is the test!!"}
    end

    let(:user) { User.create(email: "example@gmail.com", name: "test", password: "12345678", token: SecureRandom.hex) }
    let(:partnership) { Partnership.create(title: "program", description: "this program is meant to be...") }   
    
    context 'when the request is valid' do
      it 'updates the record' do
        json = JSON.parse(response.body)
        expect(json['description']).to eq('this is the test!!')
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    
    context 'when the request is invalid' do
      before do
        put :update, params: {id: partnership.id, description: "awesome"}
      end
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a validation failure message' do
        expect(response.body).to match("{\"errors\":[\"Description is too short (minimum is 15 characters)\"]}")
      end
    end
  end

  describe 'DELETE /users/:id' do
    before do
      auth_headers = {"Authorization" => "Bearer #{user.token}"}
      request.headers.merge!(auth_headers)
      delete :destroy, params: { id: partnership.id }
    end

    let(:user) { User.create(email: "example@gmail.com", name: "test", password: "12345678", token: SecureRandom.hex) }
    let(:partnership) { Partnership.create(title: "program", description: "this program is meant to be...") }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end