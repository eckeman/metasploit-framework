# -*- coding: binary -*-
require 'rex/proto/kerberos'

module Msf
  module Kerberos
    module Client
      module AsResponse

        # Extracts the session key from a Kerberos AS Response
        #
        # @param res [Rex::Proto::Kerberos::Model::KdcResponse]
        # @param key [String]
        # @return [Rex::Proto::Kerberos::Model::EncryptionKey]
        # @see Rex::Proto::Kerberos::Model::KdcResponse
        # @see Rex::Proto::Kerberos::Model::EncryptedData.decrypt
        # @see Rex::Proto::Kerberos::Model::EncKdcResponse
        # @see Rex::Proto::Kerberos::Model::EncKdcResponse.decode
        # @see Rex::Proto::Kerberos::Model::EncryptionKey
        def extract_session_key(res, key)
          decrypt_res = res.enc_part.decrypt(key, Rex::Proto::Kerberos::Crypto::ENC_AS_RESPONSE)
          enc_kdc_res = Rex::Proto::Kerberos::Model::EncKdcResponse.decode(decrypt_res)

          enc_kdc_res.key
        end

        # Extracts the logon time from a Kerberos AS Response
        #
        # @param res [Rex::Proto::Kerberos::Model::KdcResponse]
        # @param key [String]
        # @return [Fixnum]
        # @see Rex::Proto::Kerberos::Model::KdcResponse
        # @see Rex::Proto::Kerberos::Model::EncryptedData.decrypt
        # @see Rex::Proto::Kerberos::Model::EncKdcResponse
        # @see Rex::Proto::Kerberos::Model::EncKdcResponse.decode
        def extract_logon_time(res, key)
          decrypt_res = res.enc_part.decrypt(key, Rex::Proto::Kerberos::Crypto::ENC_AS_RESPONSE)
          enc_kdc_res = Rex::Proto::Kerberos::Model::EncKdcResponse.decode(decrypt_res)

          auth_time = enc_kdc_res.auth_time

          auth_time.to_i
        end
      end
    end
  end
end
