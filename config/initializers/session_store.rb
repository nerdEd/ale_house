# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ale_house_session',
  :secret      => '83b3a5114e88195b8a7378f97cfc75c4937f25f96de29f1e4731096fb1effcff0a157f719762d3c3fc4df288d162e8c86988f5a9391fe8c30d4477de19e18d5a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
