module SimpleTeams
  class AcceptInvitationsController < BaseController
    before_action :set_invitation
    before_action :ensure_invitation_token_is_valid
    before_action :set_team
    before_action :set_service_object

    def new
    end

    def create
      if params[:commit] == "Decline"
        @invitation.declined!
        redirect_to main_app.root_path, :notice => "You have declined the invitation to the '#{@team.name}' #{@team.teamable.class.model_name.human}."
      else
        if @service_object.valid?
          @service_object.perform

          SimpleTeams::Invitations::AcceptedNotification.with(
            :team_id => @team.id,
            :invitation_id => @invitation.id,
            :user_id => current_user.id,
            :team_name => @team.name,
            :invitation_name => @invitation.email,
            :user_name => current_user.full_name
          ).deliver_later(@team.members)

          redirect_to main_app.url_for(@team.teamable), :notice => "You have accepted the invitation to the '#{@team.name}' #{@team.teamable.class.model_name.human}."
        else
          render :new
        end
      end
    end

    private

      def set_invitation
        @invitation = SimpleTeams::Invitation.initial.unexpired.find_by(token: params[:id])
      end

      def ensure_invitation_token_is_valid
        unless @invitation.present?
          render "invalid_token"
        end
      end

      def set_team
        @team = @invitation.team
      end

      def set_service_object
        @service_object = SimpleTeams::AcceptInvitationService.new(current_user.id, @invitation.token)
      end

  end
end
