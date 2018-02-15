require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before (:each) do
    request.env['HTTP_ACCEPT'] = 'application/json'

    @request.env['devise.mapping'] = Devise.mappings[:user]
    @current_user = create(:user)
    sign_in @current_user
  end

  describe 'GET #index' do
    # para que os testes possam renderizarem os json
    render_views
    
    before(:each) do
      2.times do 
        create(:invitation)
      end

      2.times do
        create(:invitation, guest: @current_user)
      end

      get :index
    end
    
    it 'return http success' do
      expect(response).to have_http_status(:success)
    end
    
    it 'response only invitations for me' do
      response_hash = JSON.parse(response.body)
      expect(response_hash['invitations'].count).to eql(2)
    end
  end
  
  describe 'POST #create' do
    # para que os testes possam renderizarem os json
    render_views

    context "It's owner the team" do
      before(:each) do
        @team = create(:team, user: @current_user)
        @guest = create(:user)
        post :create, params: {
          invitation: {
            team_id: @team.id,
            guest_id: @guest.id
          }
        }
      end

      it 'return http success' do
        expect(response).to have_http_status(:success)
      end

      it 'response with right params' do
        response_hash = JSON.parse(response.body)
        
        expect(response_hash['user_id']).to eql(@team.user.id)
        expect(response_hash['guest_id']).to eql(@guest.id)
        expect(response_hash['team_id']).to eql(@team.id)
      end

      it 'created with right attributes' do
        expect(Invitation.last.user_id).to eql(@team.user.id)
        expect(Invitation.last.guest_id).to eql(@guest.id)
        expect(Invitation.last.team_id).to eql(@team.id)
      end
    end

    context "It isn't owner the team" do
      before(:each) do
        team = create(:team)
        guest = create(:user)
        post :create, params: {
          invitation: {
            team_id: team.id,
            guest_id: guest.id
          }
        }
      end

      it 'return http forbidden' do
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
