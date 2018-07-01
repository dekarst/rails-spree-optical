set :branch, :master
set :rails_env, 'production'

server '54.186.27.176', user: 'ubuntu', roles: %w{app web db}

set :nginx_server_name, 'optical.com'
