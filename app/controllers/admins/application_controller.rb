class Admins::ApplicationController < ApplicationController
  before_action :authenticate_teacher!
  before_action :is_not_admin
  
  private
  
  def is_not_admin
    redirect_to root_path, alert: "管理者のみアクセス可能です" unless current_teacher.admin?
  end
end
