class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :bookmarks, as: :bookmarkable
  has_many :playlist_selections
  has_many :playlists, through: :playlist_selections
end
