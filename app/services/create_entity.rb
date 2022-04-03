class CreateEntity < ApplicationService
  def initialize(payload)
    @payload = payload
    @errors = []
  end

  def call
    if !is_entity_valid?
      @errors << "Entity is not valid"
      Result.new(false, nil, @errors.join(", "))
    else
      entity = Entity.new(entity_params)
      if entity.save
        Result.new(true, entity)
      else
        @errors << entity.errors.full_messages
        Result.new(false, nil, @errors.join(", "))
      end
    end
  end

  def is_entity_valid?
    return false if @payload.blank?

    true
  end

  def entity_params
    {
      name: @payload[:name],
      active: @payload[:active],
      account_name: @payload[:account]
    }
  end
end
