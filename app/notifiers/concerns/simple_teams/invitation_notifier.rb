module SimpleTeams
  module InvitationNotifier
    extend ActiveSupport::Concern

    included do
      required_params :team_id, :invitation_id, :user_id, :team_name, :invitation_name, :user_name

      notification_methods do
        def message
          raise NotImplemented
        end

        def subject
          raise NotImplemented
        end

        def url
          if team.present? and team.members.include? recipient
            SimpleTeams::Engine.routes.url_helpers.team_path(team)
          end
        end

        def link_text
          "View Invitations"
        end

        # Objects
        def team
          Team.find_by(id: params[:team_id])
        end

        def user
          User.find_by(id: params[:user_id])
        end

        def invitation
          team.invitations.find_by(id: params[:invitation_id]) if team.present?
        end

        # Names (fallback)
        def team_name
          team.present? ? team.name : params[:team_name]
        end

        def invitation_name
          invitation.present? ? invitation.email : params[:invitation_name]
        end

        def user_name
          if recipient.id == params[:user_id]
            "You"
          else
            user.present? ? user.full_name : params[:user_name]
          end
        end
      end
    end
  end
end
