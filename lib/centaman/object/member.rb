module Centaman
  class Object::Member < Centaman::Object
    # rubocop:disable Metrics/MethodLength
    attr_reader :id, :package_id

    def define_variables(args)
      super
      @id = member_code # TODO confirm member code is the centaman defined ID
    end

    def json
      {
        id: id,
        member_code: member_code,
        member_number: member_number,
        first_name: first_name,
        last_name: last_name,
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
          app_key: :address,
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
          type: :integer # TODO confirm this is integer and what it's used for
        ),
        Centaman::Attribute.new(
          centaman_key: 'Incomplete',
          app_key: :incomplete,
          type: :boolean
        )
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
