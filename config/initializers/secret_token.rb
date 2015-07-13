# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Task::Application.config.secret_key_base = '7fe77e38165f1d70af16d343a74d563abbba0801f55972bab6757c034d6248bf19b1594a09c9f9f1152991e1cb19f7286cf336e7464397ce059da11a1da5c314'
