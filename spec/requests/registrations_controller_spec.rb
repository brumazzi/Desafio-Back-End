RSpec.describe "Api::V1::RegistrationsController", type: :request do
  describe "POST #create" do
    before { post api_v1_registrations_path(params: params) }

    let(:entity_name) { Faker::Company.name }

    let(:params) do
      {
        account: {
          name: Faker::Superhero.name,
          entities: [
            {
              name: entity_name
            }
          ],
          users: [{
            email: Faker::Internet.email,
            first_name: Faker::Name.female_first_name,
            last_name: Faker::Name.last_name,
            phone: Faker::PhoneNumber.cell_phone,
            entities: [entity_name]
          }]
        }
      }
    end

    it "renders 200 success" do
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include({ "id" => Account.last.id })
    end
  end
end
