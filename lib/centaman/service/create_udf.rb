module Centaman
  class Service::CreateUdf < Centaman::Service
    attr_reader :udfs, :member_code

    def after_init(args)
      @udfs = args.fetch(:udfs, [])
      @member_code = args[:member_code]
    end

    def endpoint
      "/udf_services/UDFMember?memberCode=#{member_code}"
    end

    def build_udf_body(udf)
      {
        'Value': udf.value,
        'FieldName': udf.field_name,
        'FieldType': udf.field_type,
        'FieldLength': udf.field_length,
        'TabName': udf.tab_name,
      }
    end

    def options_hash
      udfs.map { |udf| build_udf_body(udf) }.to_json
    end
  end
end
