class ArticlesController < ApplicationController
    #before_action :authenticate_user!, except: [:index, :show]
    
    def show
        @article = Article.find(params[:id])
        render json: @article 
    end

    def index
        @articles = Article.all
        response = @articles.map(&:to_array)
        render json: response 
    end

    def create
        @article = Article.new(article_params)

        if(user_signed_in?)
            @article.user = current_user
        else
            render json: {'msj' => 'unauthorized'}, status: :unauthorized
            return
        end
    
        if(@article.save)
            render json: @article, status: :created
            return
        else
            render json: @article.errors, status: :bad_request
            return
        end
    end

    def update
        @article = Article.find(params[:id])

        if(!user_signed_in?)
            render json: {'msj' => 'unauthorized'}, status: :unauthorized
            return
        else
            if (@article.user.id != current_user.id)
                render json: {'msj' => 'forbiddent'}, status: :forbidden
                return
            end
        end
        
        if @article.update(article_params)
            render json: @article, status: :created
        else
            render json: @article.errors, status: :bad_request
        end
    end

    def destroy
        @article = Article.find(params[:id])
        if(!user_signed_in?)
            render json: {'msj' => 'unauthorized'}, status: :unauthorized
            return
        else
            if (@article.user.id != current_user.id)
                render json: {'msj' => 'forbiddent'}, status: :forbidden
                return
            end
        end
        @article.destroy
        
        head :no_content
    end

  private
    def article_params
        params.require(:article).permit(:title, :text)
    end

end
