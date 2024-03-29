module SimpleTeams
  class InvitationsController < ApplicationController
    before_action :set_invitation, only: %i[ show edit update destroy ]

    # GET /invitations
    def index
      @invitations = Invitation.all
    end

    # GET /invitations/1
    def show
    end

    # GET /invitations/new
    def new
      @invitation = Invitation.new
    end

    # GET /invitations/1/edit
    def edit
    end

    # POST /invitations
    def create
      @invitation = Invitation.new(invitation_params)

      if @invitation.save
        redirect_to @invitation, notice: "Invitation was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /invitations/1
    def update
      if @invitation.update(invitation_params)
        redirect_to @invitation, notice: "Invitation was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /invitations/1
    def destroy
      @invitation.destroy
      redirect_to invitations_url, notice: "Invitation was successfully destroyed.", status: :see_other
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_invitation
        @invitation = Invitation.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def invitation_params
        params.require(:invitation).permit(:team_id, :inviter_id, :membership_id, :email, :role, :token, :status, :sent_at, :expires_at)
      end
  end
end
