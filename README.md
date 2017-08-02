# Centaman

A wrapper for the Centaman Ticketing API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'centaman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install centaman

## Usage

Retrieve Booking Type Objects
- Defaults to current date if no date parameters given
```ruby
  Centaman::Service::BookingType.new(start_date: DATE, end_date: DATE).objects
```

Find a Booking Type
- Requires the booking type id (integer) and date 
```ruby
  Centaman::Service::BookingType.find(BOOKING_TYPE_ID, DATE)
```

Retrieve Booking Time Objects for a Booking Type
- Requires the associated booking_type_id (integer)
- start_date && end_date required to retrieve booking times for a specific date, else defaults to current date
```ruby
  Centaman::Service::BookingTime.new(booking_type_id: BOOKING_TYPE_ID, start_date: DATE, end_date: DATE).objects
```

Find a Booking Time
- Requires the associated booking type id (integer), booking time id (integer), and date
```ruby
  Centaman::Service::BookingTime.find(BOOKING_TYPE_ID, BOOKING_TIME_ID, DATE)
```


## Required Environment Variables

This gem assumes the following environment variables are defined by the application

- CENTAMAN_API_URL
- CENTAMAN_API_USERNAME
- CENTAMAN_API_PASSWORD
- CENTAMAN_API_TOKEN (Optional. Required if CENTAMAN_API_USERNAME and CENTAMAN_API_PASSWORD are not provided.)
- FIXIE_URL (Optional. Used with FIXIE proxy to route outbound requests through a set of static IP addresses.)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/centaman.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

