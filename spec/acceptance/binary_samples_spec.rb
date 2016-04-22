require 'acceptance_helper'

resource 'Binary Sample' do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  get "/samples" do
    parameter :sensor_id, "Sensor ID", required: true

    let(:sensor_id) { 42 }
    let(:raw_post) { params.to_json }

    before do
      FactoryGirl.create_list(:sample, 5)
    end

    example "List samples by sensor ID" do
      do_request

      expect(status).to eq 200
      body = JSON.parse(response_body)
      expect(body.count).to eq 5
    end
  end

  post "/samples" do
    parameter :buffer, "Base64-encoded binary", required: true

    context "Correct input" do
      let(:buffer) { "AAADVwKQHwAlrL8BdgMGVwKMmwAloxgBeAMHVwKJFwAldmMBeQMH\n" }
      let(:raw_post) { params.to_json }

      example "Decode binary and save samples" do
        do_request

        expect(status).to eq 200
        body = JSON.parse(response_body)
        expect(body["message"]).to eq("OK")
        expect(Sample.count).to eq(3)
      end
    end

    context "Input with sample's capture_time in future" do
      let(:buffer) { "AAADVwKQHwAlrL8BdgMG2q0LGwAloxgBeAMHVwKJFwAldmMBeQMH\n" }
      let(:raw_post) { params.to_json }

      example "Return 422 status code and don't save samples", document: false do
        do_request

        expect(status).to eq 422
      end
    end

    context "Input with duplicate capture_time in samples" do
      let(:buffer) { "AAADVwKQHwAlrL8BdgMGVwKJFwAloxgBeAMHVwKJFwAldmMBeQMH\n" }
      let(:raw_post) { params.to_json }

      example "Return 200 status code and don't save duplicate samples", document: false do
        do_request

        expect(status).to eq 200
        body = JSON.parse(response_body)
        expect(body["message"]).to eq("OK")
        expect(Sample.count).to eq(2)
      end
    end

  end
end
