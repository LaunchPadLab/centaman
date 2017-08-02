module Centaman
  class Object::Customer < Centaman::Object
    attr_reader :phone
    # rubocop:disable Metrics/MethodLength
    def after_init(args)
      @phone = args["Address"]["HomePhone"]
    end

    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'MemberCode',
          app_key: :member_code,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'MemberNumber',
          app_key: :member_number,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'FirstName',
          app_key: :first_name,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'LastName',
          app_key: :last_name,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'Email',
          app_key: :email,
          type: :string
        ),
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
