class CreateFoundations < ActiveRecord::Migration
  def change
    create_table :foundations do |t|

      t.timestamps
    end
  end
end
