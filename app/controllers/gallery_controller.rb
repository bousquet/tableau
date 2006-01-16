class GalleryController < ApplicationController

  before_filter :login_required, :except => [:index, :list, :album]
  
  def index
    list
    render :action=>"list"
  end
  
  def list
    @photos = Photo.find :all, :order=>"position DESC"
    @albums = Album.find :all
  end
  
  def album
    @albums = Album.find :all
    @album = Album.find params[:id]
    @photos = @album.photos
    render :action=>"list"
  end
  
  def new
    @photo = Photo.new(params[:photo])
    if request.post?
      if @photo.valid? and !params[:file].nil?
        @photo.user_id = session[:user]
        @photo.save
        @photo.write(params[:file])
        flash[:notice] = 'Photo was successfully created.'
        redirect_to :action => 'list'
      else
        flash[:notice] = 'Please specify a file' if params[:file].nil?
      end
    end
  end

  def edit
    @photo = Photo.find(params[:id])
    if request.post? and @photo.update_attributes(params[:photo])
      @photo.write(params[:file]) unless params[:file].nil?
      flash[:notice] = 'Photo was successfully updated.'
      redirect_to :action => 'list'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to :action => 'list'
  end
end
