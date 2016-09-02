class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params(:title, :artist_name, :release_year, :released, :genre))
    if @song.save
      redirect_to song_path(@song)
    else
      render :new
    end
  end


  private

  def song_params(*args)
    params[:song].permit(*args)
  end

end
