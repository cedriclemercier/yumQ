# The server-based syntax can be used to override options:
# ------------------------------------
server "web06.cs.ait.ac.th",
  user: "deploy",
  roles: %w{web app db},
  ssh_options: {
    # user: "user_name", # overrides user setting above
    # keys: %w(/home/user_name/.ssh/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey)
    # password: "please use keys"
  }
