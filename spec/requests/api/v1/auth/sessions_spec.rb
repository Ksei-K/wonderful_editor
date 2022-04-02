require "rails_helper"

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }

    context "ユーザー情報が存在するとき" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, email: user.email, password: user.password) }

      it "ログインできる" do
        subject
        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["client"]).to be_present
        expect(header["expiry"]).to be_present
        expect(header["uid"]).to be_present
        expect(header["token-type"]).to be_present
        expect(response).to have_http_status(:ok)
      end
    end

    context "email が一致しないとき" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, email: "unmatch", password: user.password) }

      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        header = response.header
        expect(response).to have_http_status(:unauthorized)
        expect(response["access-token"]).to be_blank
        expect(response["client"]).to be_blank
        expect(response["expiry"]).to be_blank
        expect(response["uid"]).to be_blank
        expect(header["token-type"]).to be_blank
      end
    end

    context "password が一致しないとき" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, email: user.email, password: "unmatch") }

      it "ログインできない" do
        subject
        res = JSON.parse(response.body)
        header = response.header
        expect(response).to have_http_status(:unauthorized)
        expect(response["access-token"]).to be_blank
        expect(response["client"]).to be_blank
        expect(response["expiry"]).to be_blank
        expect(response["uid"]).to be_blank
        expect(header["token-type"]).to be_blank
      end
    end
  end
end
