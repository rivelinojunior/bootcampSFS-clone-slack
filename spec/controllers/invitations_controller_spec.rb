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

  describe 'PUT #update' do
    context 'ID is valid' do
      context "It's the guest" do
        before(:each) do
          @invitation = create(:invitation, guest: @current_user)
          put :update, params: { id: @invitation.id }
        end

        it 'return http success' do
          expect(response).to have_http_status(:success)
        end

        it 'invitation with the attribute approved truth' do
          expect(Invitation.last.approved).to eql(true)
        end

        it 'guest is part of the team' do
          expect(@invitation.team.users.ids.include?(@current_user.id)).to eql(true)
        end
      end

      context "It isn't the guest" do
        it 'return http forbidden' do
          invitation = create(:invitation)
          put :update, params: { id: invitation.id }
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context "ID isn't valid" do
      it 'return http not found' do
        id_invalid = rand(999..9999)
        put :update, params: { id: id_invalid }
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ID is valid' do
      context "It's owner of the team" do
        before(:each) do
          team = create(:team, user: @current_user)
          invitation = create(:invitation, team: team)
          delete :destroy, params: { id: invitation.id }
        end

        it 'return http success' do
          expect(response).to have_http_status(:success)
        end

        it 'removed of the database' do
          expect(Invitation.all.count).to eql(0)
        end
      end

      context "It isn't owner of the team" do
        context "It's guest of invitation" do
          before(:each) do
            invitation = create(:invitation, guest: @current_user)
            delete :destroy, params: { id: invitation.id }
          end

          it 'return http success' do
            expect(response).to have_http_status(:success)
          end

          it 'removed of the database' do
            expect(Invitation.all.count).to eql(0)
          end
        end

        context "It isn't guest of invitation" do
          it 'return http forbidden' do
            invitation = create(:invitation)
            delete :destroy, params: { id: invitation.id }
            expect(response).to have_http_status(:forbidden)
          end
        end
      end
    end

    context "ID isn't valid" do
      it 'return http notfound' do
        delete :destroy, params: { id: rand(999..9999) }
        expect(response).to have_http_status(404)
      end
    end
  end
end
