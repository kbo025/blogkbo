class CommentsController < ApplicationController
  #before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    if(!user_signed_in?)
        render json: {'msj' => 'unauthorized'}, status: :unauthorized
        return
    else
        @comment = @article.comments.create(comment_params)
        @comment.user = current_user
        if(@comment.save)
            render json: @comment, status: :created
            return
        else
            render json: @comment.errors, status: :bad_request
            return
        end
    end
    
    render json: @comment, status: :created
  end
 
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if(!user_signed_in?)
        render json: {'msj' => 'unauthorized'}, status: :unauthorized
        return
    else
        if (@article.user.id != current_user.id)
            render json: {'msj' => 'forbiddent'}, status: :forbidden
            return
        end
    end
    @comment.destroy
    head :no_content
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
