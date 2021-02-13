class AddVisibilityToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :visibility, :integer
  end
end
