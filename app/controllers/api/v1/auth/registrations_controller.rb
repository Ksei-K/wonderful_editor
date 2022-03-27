class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

    # 新規登録用のメソッド
    def sign_up_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

    # 更新用のメソッド
    def account_update_params
      params.permit(:name, :email)
    end
end
