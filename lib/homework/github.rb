module Homework
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    def initialize
      @auth_token = "2d3786fb38ef9091a3eb912d141506ce6e7807f5"
      @headers = {
        "Authorization" => "token #{@auth_token}",
        "User-Agent"    => "HTTParty"
      }
    end

    def get_user(username)
      Github.get("/users/#{username}", headers: @headers)
    end

    def list_members_by_team_name(org, team_name)
      teams = list_teams(org)
      team = teams.find { |team| team["name"] == team_name }
      list_team_members(team["id"])
    end

    def list_teams(organization)
      Github.get("/orgs/#{organization}/teams", headers: @headers)
    end

    def list_team_members(team_id)
      Github.get("/teams/#{team_id}/members", headers: @headers)
    end

    def list_issues(owner, repo)
      Github.get("/repos/#{owner}/#{repo}/issues", headers: @headers)
    end

    def close_issue(owner, repo, issue_number)
      Github.patch("/repos/#{owner}/#{repo}/issues/#{issue_number}", headers: @headers,
        body: { state: "closed" }.to_json)
    end

    def comment_on_an_issue(owner, repo, issue_number)
      Github.post("/repos/#{owner}/#{repo}/issues/#{issue_number}/comments", headers: @headers,
        body: { body: "comment"}.to_json)
    end
  end
end
