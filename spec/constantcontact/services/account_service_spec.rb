#
# account_service_spec.rb
# ConstantContact
#
# Copyright (c) 2013 Constant Contact. All rights reserved.

require 'spec_helper'

describe ConstantContact::Services::AccountService do
  describe "#get_verified_email_addresses" do
    it "gets all verified email addresses associated with an account" do
      json_response = load_file('verified_email_addresses_response.json')
      net_http_resp = Net::HTTPResponse.new(1.0, 200, 'OK')

      response = RestClient::Response.create(json_response, net_http_resp, {})
      RestClient.stub(:get).and_return(response)

      params = {}
      email_addresses = ConstantContact::Services::AccountService.get_verified_email_addresses('token', params)

      email_addresses.should be_kind_of(Array)
      email_addresses.first.should be_kind_of(ConstantContact::Components::VerifiedEmailAddress)
      email_addresses.first.email_address.should eq('abc@def.com')
    end
  end
end