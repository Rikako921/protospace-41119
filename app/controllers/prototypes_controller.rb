class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  def index
    @prototype = Prototype.all

  end

  def new
    @prototype = Prototype.new
  end
  
  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
        redirect_to  '/'
    else
      render :new
  end
end

def show
  @prototype = Prototype.find(params[:id])
  @comment = Comment.new
  @comments = @prototype.comments.includes(:user)
end

def edit
  @prototype = Prototype.find(params[:id])
  unless  user_signed_in?  && current_user.id == @prototype.user_id 
    redirect_to root_path
  end
end

def update
  @prototype = Prototype.find(params[:id])
  @prototype.update(prototype_params)
  if @prototype.save
  redirect_to prototype_path
  else
    render edit_prototype_path
  end
end

def destroy
 @prototype = Prototype.find(params[:id])
 @prototype.destroy
 redirect_to root_path

end

private

def prototype_params
  params.require(:prototype).permit(:image, :title, :concept, :catch_copy).merge(user_id: current_user.id)
end


end