class MypagesController < ApplicationController
    def index
        @user = User.find_by(id: params[:id])
    end
end
