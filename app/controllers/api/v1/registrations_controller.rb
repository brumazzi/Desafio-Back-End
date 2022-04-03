class Api::V1::RegistrationsController < ApplicationController
  def create
    result = CreateRegistration.call(create_params)

    if result.success?
      render json: result.data, status: :created
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:account)
          .permit(:name, :from_partner, :many_partners,
            { users: [:email, :first_name, :last_name, :phone, { entities: [] }] },
            { entities: %i[name active]})
  end
end
