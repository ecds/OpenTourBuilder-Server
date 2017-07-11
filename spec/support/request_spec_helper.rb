# spec/support/request_spec_helper
module RequestSpecHelper
    # Parse JSON response to ruby hash
    def json
        JSON.parse(response.body)['data']
    end

    def json_relationship(rel)
        json['relationships'][rel]['data']
    end

    def json_attributes
        json['attributes']
    end
end
