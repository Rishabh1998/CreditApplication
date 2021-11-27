module ApiHelper
    class ApiReader
        require "uri"
        require "net/http"

        def get_request(url)
            url = URI(url)

            https = Net::HTTP.new(url.host, url.port)
            https.use_ssl = true

            request = Net::HTTP::Get.new(url)
            request["X-FullContact-APIKey"] = "FULL_CONTACT_API_KEY" # Your API key here
            response = https.request(request)
            response.read_body
        end
    end
end