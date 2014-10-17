class AddVoiceLinkToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :voice_link, :text
  end
end
