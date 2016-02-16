class ArtistsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  
  def index
    @artists = Artist.all
  end

  def show
    @playlist_options = current_user.playlists.map{ |p| [p.name, p.id] }
    @artist = Artist.find(params[:id])
  end
end
