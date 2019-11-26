class CreateCrawlUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :crawl_urls do |t|
      t.string :url
      t.string :title
      t.boolean :crawled, default: false

      t.timestamps
    end
  end
end
