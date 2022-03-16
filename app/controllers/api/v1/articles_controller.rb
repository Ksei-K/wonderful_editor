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

    def create
      @article = current_user.articles.create!(article_params)

      render json: @article, serializer: Api::V1::ArticlePreviewSerializer
    end

    private

      def article_params
        params.require(:article).permit(:title, :body)
      end
  end
end
