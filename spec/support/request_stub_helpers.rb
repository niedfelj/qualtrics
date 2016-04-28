module RequestStubHelpers
  def stub_do_api(path, verb = :any)
    stub_request(verb, %r[https://org.qualtrics.com#{Regexp.escape(path)}])
  end

  def api_fixture(fixture_name)
    Pathname.new('./spec/fixtures/').join("#{fixture_name}.json").read
  end
end
