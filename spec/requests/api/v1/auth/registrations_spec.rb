require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST  /api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }

    context "適したパラメータを送信したとき" do
      let(:params) { attributes_for(:user) }

      it "ユーザー登録ができる" do
        expect { subject }.to change { User.count }.by(1)
        res = JSON.parse(response.body)
        expect(res["data"]["email"]).to eq User.last.email
        expect(response).to have_http_status(:ok)
      end

      it "header 情報を取得することができる" do
        subject
        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["client"]).to be_present
        expect(header["expiry"]).to be_present
        expect(header["uid"]).to be_present
        expect(header["token-type"]).to be_present
      end
    end

    context "送信したパラメーター(name) に不備があるとき" do
      let(:params) { attributes_for(:user, name: nil) }

      it "エラーが発生する" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["name"]).to include "can't be blank"
      end
    end

    context "送信したパラメーター(email) に不備があるとき" do
      let(:params) { attributes_for(:user, email: nil) }

      it "エラーが発生する" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["email"]).to include "can't be blank"
      end
    end

    context "送信したパラメーター(password) に不備があるとき" do
      let(:params) { attributes_for(:user, password: nil) }

      it "エラーが発生する" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["password"]).to include "can't be blank"
      end
    end
  end
end
