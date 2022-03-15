module Api::V1
  # base_api_controller を継承
  class ArticlesController < BaseApiController
    def index
      # articles = Article.all

      articles = Article.order(updated_at: :desc)

      render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
    end

    def show
      articles = Article.find(params[:id])

      render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
    end
  end
end
