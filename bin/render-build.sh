#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails db:migrate
bundle exec rails db:seed
wsl --install
wsl.exe
sudo service redis-server start
redis-cli
ping