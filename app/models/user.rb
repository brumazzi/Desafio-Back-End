class User < ApplicationRecord
  attr_accessor :entity_names

  has_many :users_entities, dependent: :destroy
  has_many :entities, through: :users_entities

  before_create :find_and_add_entity
  after_create :send_welcome_email

  validates :first_name, :last_name, :email, presence: true

  private

  def find_and_add_entity
    self.entity_ids = Entity.where(name: entity_names).pluck(:id)
  end

  def send_welcome_email
    call_to_action = { label: "Acesse agora", url: "https://fintera.com.br" }
    UserMailer.welcome_email(self, call_to_action).deliver_now
  end
end
