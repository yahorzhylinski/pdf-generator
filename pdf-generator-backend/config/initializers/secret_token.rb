# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

# Although this is not needed for an api-only application, rails4 
# requires secret_key_base or secret_token to be defined, otherwise an 
# error is raised.
# Using secret_token for rails3 compatibility. Change to secret_key_base
# to avoid deprecation warning.
# Can be safely removed in a rails3 api-only application.
PdfGeneratorBackend::Application.config.secret_token = '73efcebc2e0edee6bb0e2a84ad3a1931ec3e4e8637d93027e3b38dcd1d90f05826a9a1dd1dd6d4b0e7ebbb2ece70e426cb7ed87de7778cc0c60d7ae1432ff0c9'
