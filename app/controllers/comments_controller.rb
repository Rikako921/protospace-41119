class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)# 今回の実装には関係ありませんが、このようにPrefixでパスを指定することが望ましいです。
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show" 
    end
  end

    private
    def comment_params
      params.require(:comment).permit(:comment).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
     end
    end


