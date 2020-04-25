class PostsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def top
        @posts = Post.all 
        @array = []
        for post in @posts do
            like_num =  Like.where(post_id: post.id).count
            like_object = {'number' => like_num, 'post_id' => post.id} 
            @array.push like_object 
        end
        result = bubble_sort(@array)
        @first = Post.find(result[result.size-1]['post_id']) #一番いいねが多いやつ
        @second = Post.find(result[result.size-2]['post_id']) #２番めにいいねが多いやつ
        @third = Post.find(result[result.size-3]['post_id']) #3番めにいいねが多いやつ
    end 

    def bubble_sort(array)
        ary = array
        len = ary.length
        test = []
        (1..len).each do |i| 
            (1..(len-i)).each do |jx| 
                jy = jx - 1 
                if ary[jy]["number"] > ary[jx]["number"]
                    temp = ary[jy]
                    ary[jy] = ary[jx]
                    ary[jx] = temp
                end
            end 
        end 
        return ary 
    end

    def index
        @style = params[:style].present? ? params[:style] : "形態"
        @subject = params[:subject].present? ? params[:subject] : "教科"
        @grade = params[:grade].present? ? params[:grade] : "学年"

        posts_style = params[:style].present? ? Post.where(style: params[:style]).order(created_at: :desc) : Post.all.order(created_at: :desc)
        posts_subject = params[:subject].present? ? Post.where(subject: params[:subject]).order(created_at: :desc) : posts_style
        @posts = params[:grade].present? ? posts_style.where(grade: params[:grade]).order(created_at: :desc) : posts_subject
    end

    def narrow

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
