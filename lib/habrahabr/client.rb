module Habrahabr
  class Client
    attr_reader :oauth_token, :base_url, :client_id
    def initialize(options)
      options = HashWithIndifferentAccess.new(options)
      @oauth_token = options[:token] || options[:oauth_token] || raise(ArgumentError.new('oauth_token should be set'))
      @client_id   = options.fetch(:client_id) { raise ArgumentError, 'client_id should be set' }
      @base_url    = options.fetch(:base_url) { 'https://api.habrahabr.ru/v1/' }
    end

    def hubs(page = nil)
      list(get('hubs', page: page).body, Entities::Hub)
    end

    def hub_new(hub_name, page = nil)
      list(get("hub/#{hub_name}/new", page: page).body, Entities::Post)
    end

    def hub_habred(hub_name, page = nil)
      list(get("hub/#{hub_name}/habred", page: page).body, Entities::Post)
    end

    def posts_metadata(post_ids)
      post_ids = [post_ids].flatten
      get('posts/meta', ids: post_ids.join(',')).body.fetch('data').
          values.map {|post| Entities::Post.new(post) }
    end
    alias_method :posts_meta, :posts_metadata

    def post_comments(post_id, options = {})
      list(get("comments/#{post_id}", options).body, Entities::Comment)
    end

    protected

    def get(url, options = {}, &block)
      options = options.delete_if {|k,v| v.nil? }.
                        merge(default_request_options)
      faraday.get(url, options, &block)
    end

    def default_request_options
      {
        token: oauth_token,
        client: client_id
      }
    end

    def faraday
      @faraday ||= Faraday.new(url: base_url) do |builder|
        builder.request :json
        builder.response :follow_redirects
        builder.response :json

        builder.adapter Faraday.default_adapter
      end
    end

    def list(response, coercion_class = nil)
      Entities::ListResult.new(response, coercion_class)
    end
  end
end
