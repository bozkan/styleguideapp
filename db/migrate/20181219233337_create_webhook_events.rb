class CreateWebhookEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :webhook_events do |t|
      t.string :webhook_id
      t.datetime :api_version

      t.timestamps
    end
    add_index :webhook_events, :webhook_id, unique: true
  end
end
