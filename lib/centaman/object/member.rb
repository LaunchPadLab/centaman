module Centaman
  class Object::Member < Centaman::Object
    # rubocop:disable Metrics/MethodLength
    attr_reader :id, :package_id, :address

    def define_variables(args)
      super
      @id = member_code
      @address = set_address
    end

    def full_name
      [first_name, last_name].join(' ')
    end

    def set_address
      return unless home_address
      {
        street_address: home_address['Street1'],
        street_address_two: home_address['Street2'],
        suburb: home_address['Suburb'],
        state: home_address['State'],
        zip: home_address['Postcode'],
        city: home_address['City'],
        country: home_address['Country'],
        phone: home_address['HomePhone'],
        work_phone: home_address['WorkPhone'],
        mobile_phone: home_address['MobilePhone']
      }
    end

    def json
      {
        id: id,
        member_code: member_code,
        member_number: member_number,
        first_name: first_name,
        last_name: last_name,
        full_name: full_name,
        title: title,
        email: email,
        gender: gender,
        date_of_birth: date_of_birth,
        address: address,
        is_primary: is_primary,
        primary_member_id: primary_member_id,
        gift_purchaser_id: gift_purchaser_id,
        concession_card_number: concession_card_number,
        incomplete: incomplete,
        member_photo: member_photo,
        memberships: memberships
      }
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
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'Memberships',
          app_key: :memberships,
          type: :string
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
          centaman_key: 'Title',
          app_key: :title,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'Email',
          app_key: :email,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'Password',
          app_key: :password,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'Gender',
          app_key: :gender,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'DateOfBirth',
          app_key: :date_of_birth,
          type: :datetime
        ),
        Centaman::Attribute.new(
          centaman_key: 'HomeAddress',
          app_key: :home_address,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'IsPrimary',
          app_key: :is_primary,
          type: :boolean
        ),
        Centaman::Attribute.new(
          centaman_key: 'PrimaryMemberId',
          app_key: :primary_member_id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'GiftPurchaserId',
          app_key: :gift_purchaser_id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'ConcessionCardNumber',
          app_key: :concession_card_number,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'Incomplete',
          app_key: :incomplete,
          type: :boolean
        ),
        Centaman::Attribute.new(
          centaman_key: 'MemberPhoto',
          app_key: :member_photo,
          type: :string
        )
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
