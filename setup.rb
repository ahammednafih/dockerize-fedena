class FedenaDocker
  GITHUB_PATH = "https://raw.githubusercontent.com/ahammednafih/dockerize-fedena/main"
  DOCKER_FILES = [
    ".gitignore",
    "database.yml.docker",
    "docker-compose.yml",
    "Dockerfile",
    "Dockerfile.mariadb",
    "entrypoint.sh",
    "init.sql"
  ]

  def self.setup
    DOCKER_FILES.each do |file_name|
      print "Downloading #{file_name}...\n"
      system(`curl -O #{GITHUB_PATH}/#{file_name}`)
    end
  end
end

FedenaDocker.setup
