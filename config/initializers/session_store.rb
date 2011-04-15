# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dc_session',
  :secret      => 'fbc574d33482df3c81f9d83bfbaece22368b8805d370d3bf43cbfb328ef738e47078065bd214842321f0257810b2e783826f79fe84e6225ef4aaed4bed7c1d7e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
