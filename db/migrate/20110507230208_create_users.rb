class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :email,               :null => false # optional, you can use login instead, or both
      t.string    :artist_name
      t.string    :crypted_password,    :null => false # optional, see below
      t.string    :password_salt,       :null => false # optional, but highly recommended
      t.string    :persistence_token,   :null => false # required
      t.string    :perishable_token,    :null => false

      t.integer   :login_count,         :null => false, :default => 0
      t.integer   :failed_login_count,  :null => false, :default => 0
      t.datetime  :last_request_at                                    
      t.datetime  :current_login_at                                   
      t.datetime  :last_login_at                                      
      t.string    :current_login_ip                                   
      t.string    :last_login_ip                                      
      t.timestamps
    end

    add_index(:users, :email, :unique => true)
    add_index(:users, :artist_name, :unique => true)
  end

  def self.down
    drop_table :users
  end
end
