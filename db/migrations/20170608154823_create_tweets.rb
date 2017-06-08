Hanami::Model.migration do
  up do
    create_table :tweets do
      primary_key :id
      
      column :tweet_id, String, null: false
      column :user_id, String, null: false
      column :text, String, null: false
      column :author, String, null: false
      column :author_image_url, String, null: false
      column :favorite_count, Integer, null: false
      column :published_at, DateTime, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end

  down do 
    drop_table :tweets
  end
end
