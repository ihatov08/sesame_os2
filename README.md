# SesameOs2

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/sesame_os2`. To experiment with that code, run `bin/console` for an interactive prompt.

This gem is wrapper for using with sesame web api with ruby(sesame3, sesame4).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sesame_os2'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sesame_os2

## Usage

- Set environment variables
  - SESAME_API_KEY
  - SESAME_SSM

https://doc.candyhouse.co/ja/SesameAPI

Sesame ssm is QR code key string.

ex)

```text
ssm://UI?t=sk&sk=xxxxxxxxxxxx&l=0n=xxxxxxxxxxx
```

```ruby
client = SesameOs2::Client.new(name: 'webapi')
```

It can also be set with arguments.

```ruby
sesame_api_key = 'your api key'
sesame_ssm = 'youse sesame ssm'

client =
  SesameOs2::Client.new(
    name: 'webapi',
    api_key: sesame_api_key,
    ssm: sesame_ssm
  )
```

### status

```ruby
client.status
=>
{"batteryPercentage"=>100,
 "batteryVoltage"=>6.095014662756598,
 "position"=>223,
 "CHSesame2Status"=>"unlocked",
 "timestamp"=>1640393667,
 "wm2State"=>true}
```


### histories

```ruby
client.histories
=>
[{"recordID"=>312,
  "type"=>11,
  "timeStamp"=>1640393671108,
  "cast_type"=>:driveUnlocked},
 {"recordID"=>311,
  "type"=>17,
  "timeStamp"=>1640393668401,
  "historyTag"=>"d2ViYXBp",
  "cast_type"=>nil,
  "name"=>"webapi"}
]
```

You can also pass page or lg arguments.

```ruby
client.histories(page: 2, lg: 10)
=>
[{"recordID"=>318,
  "type"=>11,
  "timeStamp"=>1640394507582,
  "cast_type"=>:driveUnlocked}]
```

### unlock

```ruby
client.unlock
=> {:status=>200}
```

### lock

```ruby
client.lock
=> {:status=>200}
```

### toggle

```ruby
client.toggle
=> {:status=>200}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ihatov08/sesame_os2.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
