class AlbumsController < ApplicationController

  def new
    @album = Album.new params[:album]
    @album.user_id = session[:user]
    if request.post? and @album.save
      redirect_to :controller=>"gallery", :action=>"list"
    end
  end
  
  def edit
    @album = Album.find(params[:id])
    if request.post? and @album.update_attributes(params[:album]) and @album.save
      redirect_to :controller=>"gallery", :action=>"list"
    end
  end

  def add_photo
    @photo = Photo.find(params[:id].split("_")[1])
    @album = Album.find(params[:album_id])
    @album.photos << @photo if !@album.photos.include?(@photo)
    render :partial=>"/gallery/album" and return
  end

end
