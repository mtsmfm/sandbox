require 'bundler'
Bundler.require

stack = Faraday::RackBuilder.new do |builder|
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
end
Octokit.middleware = stack
Octokit.auto_paginate = true
Octokit.default_media_type = 'application/vnd.github.ironman-preview+json'

client = Octokit::Client.new(access_token: ENV['GH_API_TOKEN'])
team = client.org_teams(ENV['GH_ORG_NAME']).find {|t| t[:name] == ENV['GH_GUEST_TEAM_NAME'] }
client.org_repos(ENV['GH_ORG_NAME'], type: :private).each do |repo|
  puts repo[:full_name]
  client.add_team_repo(team[:id], repo[:full_name], permission: :push)
end
