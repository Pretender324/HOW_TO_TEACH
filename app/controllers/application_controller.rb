class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_search

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    root_path
  end

  def set_search
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:image, :status, :subject, :name])
    end
end
