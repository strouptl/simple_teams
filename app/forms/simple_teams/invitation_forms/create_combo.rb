module SimpleTeams
  class InvitationForms::CreateCombo < ApplicationForm

    attr_accessor :team, :current_user, :single_vs_multiple, :email, :emails, :select2_emails, :accessible_emails, :role, :form_instance

    def initialize(team, current_user)
      @team = team
      @current_user = current_user
    end

    def perform(params)
      # Store input
      self.assign_attributes(params)

      # Set form instance from input
      @form_instance = selected_form_klass.new(team, current_user)

      # Perform 
      if form_instance.perform(filter_params(params))
        return true
      else
        reassign_errors
        unless single?
          self.emails = form_instance.emails
        end
        false
      end
    end

    def available_roles
      @available_roles ||=
        if team.child_team?
          SimpleTeams::Membership.roles.except("owner")
        else
          SimpleTeams::Membership.roles
        end
    end

    private
    
    def single?
      !multiple? and !accessible?
    end

    def multiple?
      single_vs_multiple == "multiple"
    end

    def accessible? 
      single_vs_multiple == "accessible"
    end

    def selected_form_klass
      if single?
        SimpleTeams::InvitationForms::Create
      else
        SimpleTeams::InvitationForms::CreateBulk
      end
    end

    def filter_params(params)
      if single?
        params.except(:single_vs_multiple, :select2_emails, :accessible_emails)
      else
        params.except(:email)
      end
    end

    def reassign_errors
      [:team, :current_user, :email, :select2_emails, :accessible_emails, :role].each do |a|
        if form_instance.errors[a].present?
          form_instance.errors[a].each do |error|
            self.errors.add(a, error)
          end
        end
      end
    end

  end
end
