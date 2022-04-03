class CreateAccountAndNotifyPartners < ApplicationService
  def initialize(data)
    @params = data
  end

  def call
    return false if @params.blank?
    partners = %w[another]

    CreateAccount.call(@params, from_fintera?)
    NotifyPartner.new.perform

    partners.each do |partner|
      NotifyPartner.new(partner).perform
    end
  end

  private

  def from_fintera?
    return false unless @params[:name].include? "Fintera"

    @params[:users].each do |user|
      return true if user[:email].include? "fintera.com.br"
    end

    false
  end
end
