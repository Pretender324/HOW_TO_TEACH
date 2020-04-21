class LikesController < ApplicationController
    before_action :authenticate_user!
    def create
        @like = current_user.likes.create(post_id: params[:post_id])
        @like.save
        @post = Post.find(params[:post_id])
        render 'create.js.erb'
    end
    
    def destroy
        @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
        @like.destroy
        @post = Post.find(params[:post_id])
        render 'destroy.js.erb'
    end
end
