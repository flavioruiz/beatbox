class CreateOfferConfigurations < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      t.integer(:user_id, :null => false)
      t.string(:type, :null => false)
      t.string(:name, :null => false)
      t.string(:amg_id)
      t.timestamps
    end

    create_table :offer_locations do |t|
      t.integer(:offer_id, :null => false)
      t.string(:site , :null => false)
      t.string(:label, :null => false)
      t.string(:uri  , :null => false)
      t.timestamps
    end
  end

  def self.down
    drop_table :offer
    drop_table :offer_pages
  end
end
