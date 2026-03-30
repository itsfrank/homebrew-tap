#!/usr/bin/env ruby

require "digest"
require "json"
require "net/http"
require "open-uri"
require "pathname"
require "tempfile"

PROJECTS = {
  "portpal" => {
    repo: "itsfrank/portpal",
    formula_path: "Formula/portpal.rb",
    formula_asset_name: "portpal-cli.tar.gz",
    cask_path: "Casks/portpal-app.rb",
    cask_asset_name: "Portpal.app.zip",
  },
}.freeze

def abort_with(message)
  warn message
  exit 1
end

def fetch_json(url)
  uri = URI(url)
  response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
    request = Net::HTTP::Get.new(uri)
    request["Accept"] = "application/vnd.github+json"
    request["User-Agent"] = "itsfrank/homebrew-tap sha updater"
    http.request(request)
  end

  abort_with("GitHub API request failed: #{response.code} #{response.message}") unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
end

def sha256_for(url)
  Tempfile.create("homebrew-release") do |file|
    URI.open(url, "User-Agent" => "itsfrank/homebrew-tap sha updater") do |remote|
      IO.copy_stream(remote, file)
    end

    file.flush
    Digest::SHA256.file(file.path).hexdigest
  end
end

def update_formula(path, repo, version, asset_name, sha256)
  content = File.read(path)
  content.sub!(%r{^  url ".*"$}, %{  url "https://github.com/#{repo}/releases/download/v#{version}/#{asset_name}"})
  content.sub!(/^  sha256 ".*"$/, %{  sha256 "#{sha256}"})
  File.write(path, content)
end

def update_cask(path, sha256, version)
  content = File.read(path)
  content.sub!(/^  version ".*"$/, %{  version "#{version}"})
  content.sub!(/^  sha256 ".*"$/, %{  sha256 "#{sha256}"})
  File.write(path, content)
end

project_name = ARGV[0]
version = ARGV[1]&.sub(/^v/, "")

abort_with("Usage: ruby scripts/update-homebrew-release.rb <project> <version>") if project_name.nil? || version.nil?

project = PROJECTS[project_name]
abort_with("Unknown project '#{project_name}'. Known projects: #{PROJECTS.keys.join(', ')}") unless project

repo = project.fetch(:repo)
formula_path = Pathname(project.fetch(:formula_path))
cask_path = Pathname(project.fetch(:cask_path))

abort_with("Missing formula file: #{formula_path}") unless formula_path.exist?
abort_with("Missing cask file: #{cask_path}") unless cask_path.exist?

release = fetch_json("https://api.github.com/repos/#{repo}/releases/tags/v#{version}")
assets = release.fetch("assets")

formula_asset_name = project.fetch(:formula_asset_name)
formula_asset = assets.find { |entry| entry["name"] == formula_asset_name }
abort_with("Release asset '#{formula_asset_name}' not found for #{repo} v#{version}") unless formula_asset

cask_asset_name = project.fetch(:cask_asset_name)
cask_asset = assets.find { |entry| entry["name"] == cask_asset_name }
abort_with("Release asset '#{cask_asset_name}' not found for #{repo} v#{version}") unless cask_asset

formula_sha = sha256_for(formula_asset.fetch("browser_download_url"))
cask_sha = sha256_for(cask_asset.fetch("browser_download_url"))

update_formula(formula_path, repo, version, formula_asset_name, formula_sha)
update_cask(cask_path, cask_sha, version)

puts "Updated #{project_name} to v#{version}"
puts "Formula asset SHA256: #{formula_sha}"
puts "Cask asset SHA256:    #{cask_sha}"
