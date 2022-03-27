class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

  private

    def sign_up_params #新規登録用のメソッド
      params.permit(:name, :email, :password, :password_confirmation)
    end

    def account_update_params #更新用のメソッド
      params.permit(:name, :email)

    end

end
