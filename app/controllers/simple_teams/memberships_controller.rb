module SimpleTeams
  class MembershipsController < BaseController
    before_action :set_team
    before_action :set_membership

    def edit
      authorize! :edit, @membership
      @service_object = SimpleTeams::MembershipForm.new(@membership, current_user)
    end

    def update
      authorize! :edit, @membership
      @service_object = SimpleTeams::MembershipForm.new(@membership, current_user)

      respond_to do |format|
        if @service_object.perform(service_object_params)
          format.html { redirect_to team_path(@team), notice: "Membership was updated successfully." }
          format.json { render :show, status: :created, location: @service_object.membership }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @service_object.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize! :destroy, @membership

      member_id = @membership.member.id
      member_name = @membership.member.full_name
      recipients = @team.members.to_a

      @membership.destroy

      SimpleTeams::Memberships::DestroyedNotifier.with(
        :team_id => @team.id,
        :member_id => member_id,
        :user_id => current_user.id,
        :team_name => @team.name,
        :member_name => member_name,
        :user_name => current_user.full_name
      ).deliver_later(recipients)

      redirect_to team_path(@team)
    end

    private

      def service_object_params
        params.require(:teams_membership_form).permit(:role)
      end

      def set_team
        @team = SimpleTeams::Team.find(params[:team_id])
      end

      def set_membership
        @membership = @team.memberships.find(params[:id])
      end
  end
end
