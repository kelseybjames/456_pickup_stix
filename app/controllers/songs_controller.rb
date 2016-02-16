class SongsController < ApplicationController
  skip_before_action :require_login, only: [:show]
end
