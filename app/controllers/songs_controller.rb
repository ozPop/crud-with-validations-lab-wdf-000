class SongsController < ApplicationController
  before_action :set_song!, only: [:show, :edit, :update]

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

  def show
  end

  def edit
  end

  def update
    if @song.update(song_params(:title, :release_year, :artist_name, :released, :genre))
      redirect_to song_path(@song)
    else
      render :edit
    end
  end

  private

  def song_params(*args)
    params[:song].permit(*args)
  end

  def set_song!
    @song = Song.find(params[:id])
  end

end
