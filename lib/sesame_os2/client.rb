require 'faraday'
require 'base64'
require 'digest/cmac'
require 'json'

module SesameOs2
  class Client
    API_ENDPOINT = 'https://app.candyhouse.co/api/sesame2'

    HISTORY_TYPES = {
      0 => :none,
      1 => :bleLock,
      2 => :bleUnLock,
      3 => :timeChanged,
      4 => :autoLockUpdated,
      5 => :mechSettingUpdated,
      6 => :autoLock,
      7 => :manualLocked,
      8 => :manualUnlocked,
      9 => :manualElse,
      10 => :driveLocked,
      11 => :driveUnlocked,
      12 => :driveFailed,
      13 => :bleAdvParameterUpdated,
    }

    COMMAND = {
      toggle: 88,
      lock: 82,
      unlock: 83
    }.freeze

    def initialize(api_key: ENV['SESAME_API_KEY'], name:, ssm: ENV['SESAME_SSM'])
      @api_key = api_key
      @name = name
      @ssm = Ssm.new(ssm: ssm)
    end

    def status
      res = client.get(uuid)
      JSON.parse(res.body)
    end

    def histories(page: 0, lg: 50)
      res = client.get("#{uuid}/history", { page: page, lg: lg })
      parsed_body = JSON.parse(res.body)

      return parsed_body if res.status != 200

      parsed_body.map do |body|
        body['cast_type'] = HISTORY_TYPES[body['type']]
        body['name'] = Base64.decode64(body['historyTag']) if body['historyTag']
        body
      end
    end

    def command(command:)
      res = client.post("#{uuid}/cmd") do |req|
        req.body = { cmd: command, history: encoded64_name, sign: sign }.to_json
      end

      { status: res.status }
    end

    COMMAND.each do |command, value|
      define_method(command) do
        command(command: value)
      end
    end

    private

    attr_reader :api_key, :name, :ssm

    def client
      @client = ::Faraday.new(url: API_ENDPOINT, headers: { 'x-api-key' => api_key })
    end

    def uuid
      ssm.uuid
    end

    def secret_key
      ssm.secret_key
    end

    def encoded64_name
      Base64.strict_encode64(name)
    end

    def sign
      Sign.create(secret_key: secret_key)
    end
  end
end
