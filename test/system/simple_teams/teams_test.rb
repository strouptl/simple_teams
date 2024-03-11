require "application_system_test_case"

module SimpleTeams
  class TeamsTest < ApplicationSystemTestCase
    setup do
      @team = simple_teams_teams(:one)
    end

    test "visiting the index" do
      visit teams_url
      assert_selector "h1", text: "Teams"
    end

    test "should create team" do
      visit teams_url
      click_on "New team"

      fill_in "Teamable", with: @team.teamable_id
      fill_in "Teamable type", with: @team.teamable_type
      click_on "Create Team"

      assert_text "Team was successfully created"
      click_on "Back"
    end

    test "should update Team" do
      visit team_url(@team)
      click_on "Edit this team", match: :first

      fill_in "Teamable", with: @team.teamable_id
      fill_in "Teamable type", with: @team.teamable_type
      click_on "Update Team"

      assert_text "Team was successfully updated"
      click_on "Back"
    end

    test "should destroy Team" do
      visit team_url(@team)
      click_on "Destroy this team", match: :first

      assert_text "Team was successfully destroyed"
    end
  end
end
