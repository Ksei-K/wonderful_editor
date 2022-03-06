require "rails_helper"

RSpec.describe "User", type: :model do
  context "必要な情報が揃っているとき" do
    let(:user) { build(:user) }

    it "ユーザーを作成できる" do
      expect(user).to be_valid
    end
  end

  context "名前がないとき" do
    let(:user) { build(:user, name: nil) }
    it "エラーする" do
      expect(user).not_to be_valid
    end
  end

  context "email がないとき" do
    let(:user) { build(:user, email: nil) }
    it "エラーする" do
      expect(user).not_to be_valid
    end
  end

  context "paassword がないとき" do
    let(:user) { build(:user, password: nil) }
    it "エラーする" do
      expect(user).not_to be_valid
    end
  end
end
