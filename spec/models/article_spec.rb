# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
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
  # context "タイトルを指定しているとき" do
  #   let(:article) { build(:article) }
  #   it "記事を作成できる" do
  #     expect(article).to be_valid
  #   end
  #   # pending "add some examples to (or delete) #{__FILE__}"
  # end

  context "タイトルを指定していないとき" do
    let(:article) { build(:article, title: nil) }
    it "エラーする" do
      expect(article).not_to be_valid
    end
  end
end
