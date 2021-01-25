class AddStarttimeToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :start_time, :datetime
  end
end
