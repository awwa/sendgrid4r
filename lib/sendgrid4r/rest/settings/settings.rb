# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Settings
  #
  module Settings
    Results = Struct.new(:result)
    Result = Struct.new(:name, :title, :description, :enabled)

    def self.create_results(resp)
      return resp if resp.nil?
      results = resp['result'].map { |result| Settings.create_result(result) }
      Results.new(results)
    end

    def self.create_result(resp)
      return resp if resp.nil?
      Result.new(
        resp['name'], resp['title'], resp['description'], resp['enabled']
      )
    end
  end
end
