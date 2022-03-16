class Api::V1::BaseApiController < ApplicationController
  # current_user を定義し、仮実装として「users テーブルの一番初めのユーザー」を引用
  def current_user
    @current_user ||= User.first
  end
end
