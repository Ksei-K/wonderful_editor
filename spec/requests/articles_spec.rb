require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }

    let!(:article1) { create(:article) }
    let!(:article2) { create(:article) }
    let!(:article3) { create(:article) }

    it "記事の一覧が取得できる" do
      subject
      res = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "title", "body", "updated_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
    end
  end

  describe "GET /articles/:id" do
    subject { get(api_v1_articles_path(article_id)) }

    context "指定した id の記事が存在するとき" do
      let(:article) { create(:article) }
      let(:article_id) { article.id }

      it "指定した id の記事を取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res[0]["id"]).to eq article.id
        expect(res[0]["title"]).to eq article.title
        expect(res[0]["body"]).to eq article.body
        expect(res[0]["updated_at"]).to be_present
        expect(res[0]["user"].keys).to eq ["id", "name", "email"]
      end
    end

    # context "指定した id の記事が存在しないとき" do
    #   let(:article_id) { 10000 }

    #   fit "記事が見つからない" do
    #     expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
    #   end
    # end
  end

  describe "POST/articles/" do
    subject { post(api_v1_articles_path, params: params) }

    let(:params) { { article: attributes_for(:article) } }
    # current_user をテストのときだけ別の値として参照する
    let(:current_user) { create(:user) }

    # stub
    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    it "記事を作成できる" do
      expect { subject }.to change { Article.where(user_id: current_user.id).count }.by(1)
      res = JSON.parse(response.body)
      expect(res["title"]).to eq params[:article][:title]
      expect(res["body"]).to eq params[:article][:body]
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /articles/:id" do
    subject { patch(api_v1_article_path(article.id), params: params) }

    let(:params) { { article: attributes_for(:article) } }
    let(:article) { create(:article, user: current_user) }
    # current_user をテストのときだけ別の値として参照する
    let(:current_user) { create(:user) }
    # stub
    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    it "記事のレコードを更新をできる" do
      expect { subject }.to change { article.reload.title }.from(article.title).to(params[:article][:title]) &
                            change { article.reload.body }.from(article.body).to(params[:article][:body])
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /articles/:id" do
    subject { delete(api_v1_article_path(article.id)) }

    let(:article) { create(:article, user: current_user) }
    let(:current_user) { create(:user) }
    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    fit "記事のレコードを削除できる" do
      expect { subject }.to change { Article.count }.by(0)
      expect(response).to have_http_status(:ok)
    end
  end
end
