class Account < ApplicationRecord
  has_many :entities, dependent: :destroy

  validates :name, presence: true

  def insert_all(entities: [], users: [])
    entities.each do |entity|
      Entity.create(**entity, account_id: self.id)
    end

    users.each do |user|
      User.create(**user)
    end
  end
end
