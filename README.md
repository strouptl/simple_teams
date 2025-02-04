# SimpleTeams
SimpleTeams is an all-in-one solution for implementing teams quickly in a Ruby on Rails (RoR) application. It follows best practices, using the Rails Engine design pattern for easy configurability, CanCan for authorization, and polymorphic association (like ActiveStorage) to avoid dictating model names.

## STATUS
SimpleTeams is actually in use within several client-facing applications. However, the gem is still under development, and notably lacks standalone testing.

That said, feel free to try it out, and let us know if you have any comments/questions. Just make sure to test things thoroughly, and be patient with the (sparse) documentation.

## Installation
1. Add simple\_teams to your Gemfile and run bundle install

2. Add the necessary initializers to your config directory (NEED TO ADD DETAILS)
a. devise.rb (see devise gem for further details)
b. simple\_form.rb (see simple\_form gem for further details)
c. simple\_teams.rb (NEED TO MAKE THIS AN INSTALL SCRIPT)

3. Install the necessary migrations for simple\_teams and it's dependencies
`
devise generate User
rails noticed:install:migrations
rails simple\_teams:install:migrations
`

4. Add the SimpleTeams concerns to the desired models. E.g.
`
#app/models/user.rb
class User
  include SimpleTeams::MemberObject
...

#app/models/Organization.rb
class Organization
  include SimpleTeams::TeamObject
...
`

5. Make sure to initialize the TeamObject properly via the InitializeTeamService to specify the owner of the team. E.g.

`
#within the create action of app/controllers/organizations_controller.rb

def create
  if @organization.update(organization_params)
    SimpleTeams::InitializeTeamService.new(current_user, @organization.team).perform
    redirect_to @organization, ...
...
`

## Usage
1. SimpleTeams comes pre-packaged with all of the necessary controllers and views for adding/updating/removing team members. For the default functionality, you can simply link from the teamable object (e.g. the "Organization") to the team for users to view/manage these permissions. E.g.

`
#app/views/organizations/show.html.erb
...
link_to "Organization Roles", simple_teams.team_path(@organization.team)
...
`

2. The breadcrumbs in these views will reference the default routes for the teamable resource automatically. E.g.
Organizations / Test Organization / Team Members

However, you can customize these views, as well, by installing them in your application via the standard Engine functionality (i.e. "rails simple\_teams:install:views")

3. NOTE: NEED TO ADD INSTRUCTIONS REGARDING locale configuration.

## Contributing
This gem is still in its initial stages, so it is important to ensure that it grows in the proper directions.

That said, contributions are welcome, but please give me a heads up on your ideas (via Github issues) so that we can discuss them beforehand.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
