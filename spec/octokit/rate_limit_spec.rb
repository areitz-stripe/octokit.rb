require 'helper'
require 'octokit/rate_limit'

describe Octokit::RateLimit do

  it "parses rate limit info from response headers" do
    response = double()
    response.should_receive(:headers).
      at_least(:once).
      and_return({
        "X-RateLimit-Limit" => 60,
        "X-RateLimit-Remaining" => 42
      })
    info = Octokit::RateLimit.from_response(response)
    expect(info.limit).to eq 60
    expect(info.remaining).to eq 42
  end

  it "handles nil responses" do
    info = Octokit::RateLimit.from_response(nil)
    expect(info.limit).to be_nil
    expect(info.remaining).to be_nil
  end

end