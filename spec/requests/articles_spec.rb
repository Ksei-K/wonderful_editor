require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }

    let!(:article1) { create(:article, :published, updated_at: 1.days.ago) }
    let!(:article2) { create(:article, :published, updated_at: 2.days.ago) }
    let!(:article3) { create(:article, :published) }

    before { create(:article, :draft) }

    it "公開している記事の一覧が取得できる" do
      subject
      res = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "title", "body", "status", "updated_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
    end
  end

  describe "GET /articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    context "指定した id の記事が公開されているとき" do
      let(:article_id) { article.id }
      let(:article) { create(:article, :published) }

      it "指定した id の記事を取得できる" do
        subject
        res = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(res["id"]).to eq article.id
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["updated_at"]).to be_present
        expect(res["user"].keys).to eq ["id", "name", "email"]
      end
    end

    context "指定した id の記事が下書きのとき" do
      let(:article_id) { article.id }
      let(:article) { create(:article, :draft) }

      it "記事が見つからない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "指定した id の記事が存在しない場合" do
      let(:article_id) { 10000 }

      it "記事が見つからない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST/articles/" do
    subject { post(api_v1_articles_path, params: params, headers: headers) }

    let(:params) { { article: attributes_for(:article) } }
    # current_user をテストのときだけ別の値として参照する
    let(:current_user) { create(:user) }

    let(:headers) { current_user.create_new_auth_token }

    it "記事を作成できる" do
      expect { subject }.to change { Article.where(user_id: current_user.id).count }.by(1)
      res = JSON.parse(response.body)
      expect(res["title"]).to eq params[:article][:title]
      expect(res["body"]).to eq params[:article][:body]
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /articles/:id" do
    subject { patch(api_v1_article_path(article.id), params: params, headers: headers) }

    let(:params) { { article: attributes_for(:article) } }
    let(:article) { create(:article, user: current_user) }
    # current_user をテストのときだけ別の値として参照する
    let(:current_user) { create(:user) }
    # stub
    let(:headers) { current_user.create_new_auth_token }

    it "記事のレコードを更新をできる" do
      expect { subject }.to change { article.reload.title }.from(article.title).to(params[:article][:title]) &
                            change { article.reload.body }.from(article.body).to(params[:article][:body])
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /articles/:id" do
    subject { delete(api_v1_article_path(article.id), headers: headers) }

    let(:article) { create(:article, user: current_user) }
    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }

    it "記事のレコードを削除できる" do
      expect { subject }.to change { Article.count }.by(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
