require 'base64'

module SesameOs2
  class Ssm
    def initialize(ssm:)
      @ssm = ssm
    end

    def name
      information['n']
    end

    def uuid
      unpacked = unpacked_sk[83..99].pack("C*").unpack("H*").first.upcase

      parts = [
        unpacked[0..7],
        unpacked[8..11],
        unpacked[12..15],
        unpacked[16..19],
        unpacked[20..-1]
      ]

      parts.join('-')
    end

    def key_index
      unpacked_sk[81..82].pack("C*").unpack("H*").first
    end

    def secret_key
      unpacked_sk[1..16].pack("C*").unpack("H*").first
    end

    def public_key
      unpacked_sk[17..80].pack("C*").unpack("H*").first
    end

    def information
      URI::decode_www_form(parsed_ssm.query).to_h
    end

    private

    attr_reader :ssm

    def parsed_ssm
      URI.parse(ssm)
    end

    def sk
      information['sk']
    end

    def unpacked_sk
      Base64.decode64(sk).unpack("C*")
    end
  end
end
