# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_beatbox_session',
  :secret      => '074dc396f2e2f79f33abf699577629b77f51ea6c5a778719b60e88753dd24c5bf8753f2b8e371a80340061e9b63d03988745938db5d089a6cb74b8e4eb6c0b8d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
