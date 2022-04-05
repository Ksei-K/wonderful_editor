# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :integer          default(NULL), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Article, type: :model do
  context "タイトルを指定しているとき" do
    let(:article) { build(:article) }
    it "記事を作成できる" do
      expect(article).to be_valid
    end
  end

  context "タイトルを指定していないとき" do
    let(:article) { build(:article, title: nil) }
    it "エラーする" do
      expect(article).not_to be_valid
    end
  end

  context "status が下書き状態のとき" do
    let(:article) { build(:article, :draft) }

    it "記事を下書き状態で作成できる" do
      expect(article).to be_valid
      expect(article.status).to eq "draft"
    end
  end

  context "status が公開状態のとき" do
    let(:article) { build(:article, :published) }

    it "記事を公開状態で作成できる" do
      expect(article).to be_valid
      expect(article.status).to eq "published"
    end
  end
end
