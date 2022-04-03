class CreateUser < ApplicationService
  def initialize(payload)
    @payload = payload
    @errors = []
  end

  def call
    if !is_user_valid?
      @errors << "User is not valid"
      Result.new(false, nil, @errors.join(", "))
    else
      user = User.new(user_params)
      if user.save
        Result.new(true, user)
      else
        @errors << user.errors.full_messages
        Result.new(false, nil, @errors.join(", "))
      end
    end
  end

  def is_user_valid?
    return false if @payload.blank?

    true
  end

  def user_params
    entities = Entity.where(name: @payload[:entities])

    {
      first_name: @payload[:first_name],
      last_name: @payload[:last_name],
      email: @payload[:email],
      phone: @payload[:phone].to_s.gsub(/\D/, ""),
      entity_names: @payload[:entities]
    }
  end
end
