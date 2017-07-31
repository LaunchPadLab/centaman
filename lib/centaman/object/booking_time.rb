module Centaman
  #:nodoc:
  # rubocop:disable Metrics/ClassLength
  class Object::BookingTime < Centaman::Object
    attr_reader :sold_out, :is_all_day, :show_time

    def define_variables(args)
      super
      @sold_out = vacancy <= 0 || is_booked_exclusively
      @is_all_day = is_all_day?
      @display_start_time = 'All Day' if is_all_day?
      @show_time = show_time?
    end

    def is_all_day?
      all_day_descriptions = ['all','2 day']
      all_day_descriptions.any? { |all_day_description| description.downcase.include?(all_day_description) }
    end

    def filter_start_time
      return "IKEA" if booking_type_id == 91000208
      return "VIP All Day" if booking_type_id == 2000209
      return "2 Day" if booking_type_id == 2000275
      display_start_time
    end

    def set_start_time
      return "16:00:00" if booking_type_id == 2000275
      start_time
    end

    def show_time?
      skip_descriptions = ['all day', 'ikea', '2 day']
      !skip_descriptions.any? { |description_to_skip| filter_start_time.downcase.include?(description_to_skip) }
    end

    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    def json
      {
        id: id,
        booking_type_id: booking_type_id,
        booking_type_description: booking_type_description,
        description: description,
        start_date: start_date.strftime('%Y-%m-%d'),
        start_time: set_start_time,
        end_time: end_time,
        display_start_time: filter_start_time,
        display_end_time: display_end_time,
        capacity: capacity,
        vacancy: vacancy,
        remaining: remaining,
        booking_fee: booking_fee,
        booking_fee_item_code: booking_fee_item_code,
        cancelled: cancelled,
        sold_out: sold_out,
        is_all_day: is_all_day?,
        show_time: show_time?
      }
    end
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    def attributes
      [
        Centaman::Attribute.new(
          centaman_key: 'TimedTicketTypeId',
          app_key: :id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'BookingTypeId',
          app_key: :booking_type_id,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'BookingTypeDescription',
          app_key: :booking_type_description,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'TimedTicketTypeDescription',
          app_key: :description,
          type: :centaman_description
        ),
        Centaman::Attribute.new(
          centaman_key: 'StartDate',
          app_key: :start_date,
          type: :datetime
        ),
        Centaman::Attribute.new(
          centaman_key: 'StartTime',
          app_key: :start_time,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'EndTime',
          app_key: :end_time,
          type: :string
        ),
        Centaman::Attribute.new(
          centaman_key: 'StartTime',
          app_key: :display_start_time,
          type: :display_time
        ),
        Centaman::Attribute.new(
          centaman_key: 'EndTime',
          app_key: :display_end_time,
          type: :display_time
        ),
        Centaman::Attribute.new(
          centaman_key: 'Capacity',
          app_key: :capacity,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'vacancy',
          app_key: :vacancy,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'vacancy',
          app_key: :remaining,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'Bookingfee',
          app_key: :booking_fee,
          type: :float
        ),
        Centaman::Attribute.new(
          centaman_key: 'BookingFeeItemCode',
          app_key: :booking_fee_item_code,
          type: :integer
        ),
        Centaman::Attribute.new(
          centaman_key: 'Cancelled',
          app_key: :cancelled,
          type: :boolean
        ),
        Centaman::Attribute.new(
          centaman_key: 'IsBookedExclusively',
          app_key: :is_booked_exclusively,
          type: :boolean
        )
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
