#
# email_marketing_service_spec.rb
# ConstantContact
#
# Copyright (c) 2013 Constant Contact. All rights reserved.

require 'spec_helper'

describe ConstantContact::Services::EmailMarketingService do
  describe "#get_campaigns" do
    it "returns an array of campaigns" do
      json_response = load_file('email_campaigns_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json_response, net_http_resp, {})
      RestClient.stub(:get).and_return(response)

      campaigns = ConstantContact::Services::EmailMarketingService.get_campaigns('token')
      campaigns.should be_kind_of(ConstantContact::Components::ResultSet)
      campaigns.results.first.should be_kind_of(ConstantContact::Components::Campaign)
      campaigns.results.first.name.should eq('1357157252225')
    end
  end

  describe "#get_campaign" do
    it "returns a campaign" do
      json_response = load_file('email_campaign_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json_response, net_http_resp, {})
      RestClient.stub(:get).and_return(response)

      campaign = ConstantContact::Services::EmailMarketingService.get_campaign('token', 1)
      campaign.should be_kind_of(ConstantContact::Components::Campaign)
      campaign.name.should eq('Campaign Name')
    end
  end

  describe "#add_campaign" do
    it "adds a campaign" do
      json = load_file('email_campaign_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {})
      RestClient.stub(:post).and_return(response)
      new_campaign = ConstantContact::Components::Campaign.create(JSON.parse(json))

      campaign = ConstantContact::Services::EmailMarketingService.add_campaign('token', new_campaign)
      campaign.should be_kind_of(ConstantContact::Components::Campaign)
      campaign.name.should eq('Campaign Name')
    end
  end

  describe "#delete_campaign" do
    it "deletes a campaign" do
      json = load_file('email_campaign_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 204, 'No Content')

      response = RestClient::Response.create('', net_http_resp, {})
      RestClient.stub(:delete).and_return(response)
      campaign = ConstantContact::Components::Campaign.create(JSON.parse(json))

      result = ConstantContact::Services::EmailMarketingService.delete_campaign('token', campaign)
      result.should be_true
    end
  end

  describe "#update_campaign" do
    it "updates a campaign" do
      json = load_file('email_campaign_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json, net_http_resp, {})
      RestClient.stub(:put).and_return(response)
      campaign = ConstantContact::Components::Campaign.create(JSON.parse(json))

      result = ConstantContact::Services::EmailMarketingService.update_campaign('token', campaign)
      result.should be_kind_of(ConstantContact::Components::Campaign)
      result.name.should eq('Campaign Name')
    end
  end
end