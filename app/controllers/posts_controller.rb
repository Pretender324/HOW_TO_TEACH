class PostsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def top
        @posts = Post.all.order(likes: :desc)
    end 

    def index
        @q = Post.ransack(params[:q])
        @posts = @q.result(distinct: true)
    end

    def new
        @post = Post.new()
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        if @post.save
        redirect_to action: "index"
        else
        redirect_to action: "new"
        end
    end

    def show
        @post = Post.find_by(id: params[:id])
        @like = Like.new
    end

    def edit
        @post = Post.find_by(id: params[:id])
    end

    def update
        @post = Post.find_by(id: params[:id])
        
        if @post.update(post_params)
            redirect_to action: "index"
        else
            redirect_to action: "edit"
        end

    end
    
    def destroy
        Post.find(params[:id]).destroy
        redirect_to action: :index
    end

    def search
        if params[:search] == nil
            @posts= Post.all
        elsif params[:search] == ''
            @posts= Post.all
        else
            #部分検索
            @posts = Post.where("contents LIKE ? ",'%' + params[:search] + '%')
            @keyword = params[:search]
        end
    end

    def search_multiple
    end

    private
    #セキュリティのため、許可した:bodyというデータだけ取ってくるようにする
    def post_params
        params.require(:post).permit(:title, :contents, :style, :subject, :grade)
    end
    
end
