require "rails_helper"

RSpec.describe FlightController, type: :controller do
  let(:query) do
    {
      departure_location: nil,
      arrival_location: nil,
      departure_date: nil
    }
  end

  before(:all) do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.all
  end

  def visit_search
    get :search, query: query
  end

  describe "prune params" do
    context "when query params are blank" do
      it "returns blank hash" do
        visit_search
        expect(controller.send(:prune_params)).to eq({})
      end
    end

    context "when query params are not blank" do
      it "return query params" do
        get :search, query: { departure_location: "Ilorin" }
        expect(controller.send(:prune_params)).to include("departure_location")
        expect(controller.send(:prune_params)[:departure_location]).
          to eql("Ilorin")
      end
    end
  end

  describe "search" do
    context "when query is blank" do
      it "returns all flights" do
        visit_search
        expect(response.content_type).to eql("application/json")
      end
    end

    context "when query has nil params" do
      it "returns all flights" do
        get :search, query: { departure_location: nil }
        expect(response.content_type).to eql("application/json")
      end
    end
  end

  describe "flights method" do
    context "when query has one parameter supplied" do
      it "returns search results" do
        get :search, query: { departure_location: Airport.first.name }
        result = JSON.parse(response.body)
        expect(result).to be_kind_of(Array)
      end

      it "returns search results" do
        get :search, query: { arrival_location: Airport.find_by(id: 50).name }
        result = JSON.parse(response.body)
        expect(result).to be_kind_of(Array)
      end
    end

    context "when 2 parameters are provided" do
      it "returns search results" do
        query = { departure_location: "Nadzab", arrival_location: "Deurne" }
        get :search, query: query
        result = JSON.parse(response.body)
        expect(result).to be_kind_of(Array)
      end
    end
  end
end
