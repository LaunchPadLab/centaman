module Centaman
  class Object::AttendeeDetail < Centaman::Object
    attr_accessor :ticket_type, :ticket_id, :udfs

    def after_init(args= {})
      @ticket_type = args.fetch(:ticket_type, nil)
      @ticket_id = args.fetch(:ticket_id, nil)
      @udfs = set_attendee_udfs(args[:udfs] || [])
    end

    def json
      {
        'AttendeeFirstName': first_name,
        'AttendeeLastName': last_name,
        'AttendeeMemberCode': member_code || ''
      }.as_json
    end

    def set_attendee_udfs(attendee_udfs)
      attendee_udfs.map do |u|
        Centaman::Object::Udf.new(
          is_email: u[:is_email],
          value: u[:value],
          field_name: u[:field_name],
          field_type: u[:field_type],
          field_length: u[:field_length],
          tab_name: u[:tab_name]
        )
      end
    end

    def full_name
      [first_name, last_name].compact.join(' ')
    end

    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'MemberCode',
          app_key: :member_code,
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
        )
      ]
    end
  end
end
