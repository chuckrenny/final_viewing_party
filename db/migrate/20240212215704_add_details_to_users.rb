class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password_digest, :string
    add_index :users, :email, unique: true # optimize the retrieval of data for columns heavily used in search operations
  end
end
