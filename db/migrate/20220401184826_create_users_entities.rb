class CreateUsersEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :users_entities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :entity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
