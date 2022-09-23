# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "ps1"
set :repo_url, "git@gitlab.com:ait-fsad-2022/web6/PS1.git"
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :rbenv_type, :user
set :rbenv_ruby, '3.1.2'
set :rbenv_path, '/home/deploy/.rbenv'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/ps1"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
set :default_env, { 
    'https_proxy' => 'http://192.41.170.23:3128/',
    'http_proxy' => 'http://192.41.170.23:3128/'
 }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
set :ssh_options, verify_host_key: :always
