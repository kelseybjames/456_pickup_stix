class PlaylistsController < ApplicationController
  skip_before_action :require_login, only: [:show]
  def show
    @playlist = Playlist.find(params[:id])
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    @playlist = Playlist.find(params[:id])
  end

  def destroy
    @playlist = Playlist.find(params[:id])
  end

  private

  def whitelisted_playlist_params
    params.require(:playlist).permit(:name)
  end
end
