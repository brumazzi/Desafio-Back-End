class Entity < ApplicationRecord
  attr_accessor :account_name

  belongs_to :account
  has_many :users_entities, dependent: :destroy
  has_many :users, through: :users_entities

  validates :name, presence: true

  private

  def find_and_add_entity
    self.entity_ids = Entity.where(name: entity_names).pluck(:id)
  end
end
