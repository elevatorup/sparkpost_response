[![Build Status](https://travis-ci.org/elevatorup/sparkpost_response.svg?branch=master)](https://travis-ci.org/elevatorup/sparkpost_response) [![Code Climate](https://codeclimate.com/github/elevatorup/sparkpost_response/badges/gpa.svg)](https://codeclimate.com/github/elevatorup/sparkpost_response/feed)
# SparkpostResponse

This Gems purpose design is to being able to communicate with Sparkpost's API. We want to provide a simple yet powerful way to interact with Sparkpost with the support that Ruby On Rails provides as a solid framework.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sparkpost_response'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sparkpost_response

## Usage

For **Rails**: `/config/initializers/sparkpost_response.rb`
```ruby
SparkpostResponse.configure do |c|
      c.api_key = [KEY]
    end
```

###Message Events
```ruby
SparkPostResponse::MessageEvents.open_messages_event #=> [{type:"bounce", bounce_class: "1"}]
SparkPostResponse::MessageEvents.bounce_messages_event(recipients: ["john@example.com"], subject: "Hello World!")
```

####Bounce meta data
[Bounce Classification](https://support.sparkpost.com/customer/portal/articles/1929896)
```ruby
SparkPostResponse::MessageEvents.messages_event.classify_bounces #=> {... classify_bounce: { no_rcpt: { level: :hard, code: 30 } }
````

A list of all options for given MessageEvents can be found: [Sparkpost API#MessageEvents](https://developers.sparkpost.com/api/message-events.html).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributions and Credits
[Sparkpost Rails](https://github.com/the-refinery/sparkpost_rails)
