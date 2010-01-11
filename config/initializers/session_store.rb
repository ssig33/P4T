# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_picture_session',
  :secret      => 'a617898fde87d464bf29d382fbbc2fe0fd5b279a417a8e0be8e3e0af15ef82dafab0e2d95b83b4ae0f73242adbfff85b2069879e389110bb4d1cde28dcd3504e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
