Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      column :nickname, String, null: false
      column :twitter_id, Integer, null: false
      column :twitter_access_token, String, null: false
      column :twitter_access_secret, String, null: false
      column :name, String
      column :image, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
