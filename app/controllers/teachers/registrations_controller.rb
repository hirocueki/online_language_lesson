# frozen_string_literal: true

class Teachers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: %i[create]
  before_action :configure_account_update_params, only: %i[update]
  before_action :creatable?, only: %i[new create]

  prepend_before_action :require_no_authentication, only: %i[cancel]
  prepend_before_action :authenticate_scope!, only: %i[new create edit update destroy]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar introduce])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar introduce])
  end

  def current_teacher_is_admin?
    teacher_signed_in? && current_teacher.admin?
  end

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource) unless current_teacher_is_admin?
  end

  def creatable?
    raise 'アクセス権限がありません' unless teacher_signed_in?

    raise 'アクセス権限がありません' unless current_teacher_is_admin?
  end
end
