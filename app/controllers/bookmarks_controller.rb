class BookmarksController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def create
    @bookmark = Bookmark.new(user_id: current_user.id, bookmarkable_id: params[:id], bookmarkable_type: @parent.class)
    if @bookmark.save
      flash[:success] = 'Bookmark made'
    else
      flash[:error] = 'Bookmarking failed'
    end
    redirect_to request.referrer
  end
  
  def show
    @bookmark = Bookmark.find(params[:id])
    @parent = extract_bookmarkable.find(@bookmark.bookmarkable_id)
  end

  private

  def extract_bookmarkable
    @bookmark.bookmarkable_type.constantize
  end
end
