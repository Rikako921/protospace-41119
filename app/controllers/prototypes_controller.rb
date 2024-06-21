class PrototypesController < ApplicationController
  def index
    
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
private

def prototype_params
  params.require(:prototype).permit(:image, :title, :concept, :catch_copy).merge(user_id: current_user.id)
end
end
