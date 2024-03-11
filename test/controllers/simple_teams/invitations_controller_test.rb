require "test_helper"

module SimpleTeams
  class InvitationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @invitation = simple_teams_invitations(:one)
    end

    test "should get index" do
      get invitations_url
      assert_response :success
    end

    test "should get new" do
      get new_invitation_url
      assert_response :success
    end

    test "should create invitation" do
      assert_difference("Invitation.count") do
        post invitations_url, params: { invitation: { email: @invitation.email, expires_at: @invitation.expires_at, inviter_id: @invitation.inviter_id, membership_id: @invitation.membership_id, role: @invitation.role, sent_at: @invitation.sent_at, status: @invitation.status, team_id: @invitation.team_id, token: @invitation.token } }
      end

      assert_redirected_to invitation_url(Invitation.last)
    end

    test "should show invitation" do
      get invitation_url(@invitation)
      assert_response :success
    end

    test "should get edit" do
      get edit_invitation_url(@invitation)
      assert_response :success
    end

    test "should update invitation" do
      patch invitation_url(@invitation), params: { invitation: { email: @invitation.email, expires_at: @invitation.expires_at, inviter_id: @invitation.inviter_id, membership_id: @invitation.membership_id, role: @invitation.role, sent_at: @invitation.sent_at, status: @invitation.status, team_id: @invitation.team_id, token: @invitation.token } }
      assert_redirected_to invitation_url(@invitation)
    end

    test "should destroy invitation" do
      assert_difference("Invitation.count", -1) do
        delete invitation_url(@invitation)
      end

      assert_redirected_to invitations_url
    end
  end
end
