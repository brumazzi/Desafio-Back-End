class CreateAccount < ApplicationService
  def initialize(payload, from_fintera = false)
    @payload = payload
    @from_fintera = from_fintera
    @errors = []
  end

  def call
    if !is_account_valid?
      @errors << "Account is not valid"
      Result.new(false, nil, @errors.join(","))
    else
      account = Account.new(account_params)
      if account.save && account.insert_all(entities: entities_params, users: users_params)
        Result.new(true, account)
      else
        @errors << account.errors.full_messages
        Result.new(false, nil, @errors.join(","))
      end
    end
  end

  def is_account_valid?
    return false if @payload.blank?

    true
  end

  def account_params
    {
      name: @payload[:name],
      active: @from_fintera,
    }
  end

  def entities_params
    @payload[:entities] ||= []
    @payload[:entities].map do |entity|
      {
        name: entity[:name],
        active: entity[:active]
      }
    end
  end

  def users_params
    @payload[:users] ||= []
    @payload[:users].map do |user|
      {
        first_name: user[:first_name],
        last_name: user[:last_name],
        email: user[:email],
        phone: user[:phone].to_s.gsub(/\D/, ""),
        entity_names: user[:entities]
      }
    end
  end
end
