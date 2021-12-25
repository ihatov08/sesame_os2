module SesameOs2
  class Sign
    def initialize(secret_key:)
      @secret_key = secret_key
    end

    class << self
      def create(secret_key:)
        new(secret_key: secret_key).create
      end
    end

    def create
      digest.unpack1("H*")
    end

    private

    attr_reader :secret_key

    def message
      [Time.now.to_i].pack("i*").unpack1("H*")[2, 8]
    end

    def key
      [secret_key].pack("H*")
    end

    def cmac
      Digest::CMAC.new(OpenSSL::Cipher.new("aes-128-cbc"), key).tap do |c|
        c.update([message].pack("H*"))
      end
    end

    def digest
      cmac.digest
    end
  end
end
