class PhotosController < ApplicationController
  #告訴rails在執行任何動作前，先執行set_photo.
  before_action :set_photo, :only => [:show, :edit, :update, :destroy]
  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    
    # 加入if 在驗證失敗後不會回到homepage ，而仍然停在原頁面讓使用者能繼續新增或編輯
    if @photo.save

        # 如果Action不要render任何結果，而是要使用者轉向到別頁，可以使用redirect_to ; https://ihower.tw/rails/actioncontroller.html
        redirect_to photos_url
    else
        render :action => :new
    end
          
  end

  def show
    # set_photo 在開頭已經由before action統一宣告及執行，方便維護程式碼
  end

  def edit
    # set_photo 在開頭已經由before action統一宣告及執行，方便維護程式碼    
  end

  def update
    # set_photo 在開頭已經由before action統一宣告及執行，方便維護程式碼
    
    # 加入if 在驗證失敗後不會回到homepage ，而仍然停在原頁面讓使用者能繼續新增或編輯
    if @photo.update_attributes(photo_params)

      redirect_to photo_path(@photo)
    else
      render :action => :edit
    end

  end

  def destroy
    # set_photo 在開頭已經由before action統一宣告及執行，方便維護程式碼
    @photo.destroy

    redirect_to photos_url
  end

  # Rails會檢查使用者傳進來的參數必須經過一個過濾的安全步驟，這個機制叫做Strong Parameters，所以用private method
  private

  #重構程式碼，取代上面重複的程式碼
  def set_photo
    @photo = Photo.find(params[:id])
  end


  # Strong Parameters: https://ithelp.ithome.com.tw/articles/10161397
  # require 會把 :photo 這個model相關參數找出來，如果根本沒有回傳 :photo 相關參數，就會產生錯誤
  # permit 就是設定哪些參數可以傳入
  def photo_params

    # 透過 require 和 permit 將params這個hash過濾成 params[:photo][:title], params[:photo][:date]...params[:photo][:file_location]
    params.require(:photo).permit(:title, :date, :description, :file_location)
  end

end
