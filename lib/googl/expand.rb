module Googl

  class Expand < Base

    include Googl::Utils

    attr_accessor :long_url, :analytics, :status, :short_url, :created

    # Expands a short URL or gets creation time and analytics. See Googl.expand
    #
    def initialize(options={}, api_key)

      options.delete_if {|key, value| value.nil?}

      expand_url = API_URL
      if (api_key != nil && !api_key.empty?)
        expand_url += "?key=#{api_key}"
      end
      resp = get(expand_url, :query => options)
      if resp.code == 200
        self.created    = resp['created'] if resp.has_key?('created')
        self.long_url   = resp['longUrl']
        self.analytics  = resp['analytics'].to_openstruct if resp.has_key?('analytics')
        self.status     = resp['status']
        self.short_url  = resp['id']
      else
        raise exception("#{resp.code} #{resp.message}")
      end
    end

  end

end
