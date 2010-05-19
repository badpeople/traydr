# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_traydr_session',
  :secret      => 'f21b7f7652a2e2b4af86905f9db551e5b50fa8b49becd70ceb1eeb020c0a33c74c4d80a43265be84ead151849c3720375f219d83a89009c3661a95597f274271'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
