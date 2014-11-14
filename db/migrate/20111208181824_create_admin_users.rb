class CreateAdminUsers < ActiveRecord::Migration
  def self.up
    create_table :admin_users do |t|
      t.string :name
      t.string :login
      t.string :email
      t.boolean :follow_requests
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token

      t.timestamps
    end
  end

  def self.down
    drop_table :admin_users
  end
end
