lock '3.2.1'

set :application, 'optical'
set :repo_url, 'git@bitbucket.org:vangjel_qaqi/optical.git'
set :user, 'ubuntu'

set :ssh_options, {forward_agent: true, auth_methods: ['publickey'], keys: ['~/.ssh/feanor.pem']}

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads public/assets}

# Default value for default_env is {}
# set :default_env, {path: "/opt/ruby/bin:$PATH"}

set :keep_releases, 10
