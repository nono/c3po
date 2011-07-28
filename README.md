C3PO
====

Ruby translator client. Actual provider :

 * Google Translate
 * Bing Translate

Ruby 1.9.2 is strongly recommanded.


Dependency
----------

`libcurl4-gnutls-dev`


Installation
------------

Install it with rubygems:

``` ruby
gem install c3po
```

With bundler, add it to your `Gemfile`:

``` ruby
gem "c3po", "~>0.1"
```


Usage
-----

``` ruby
# Define a provider
C3po.configure do |config|
  config.provider = :google
  config.google_api_key = "MYAPIKEY"
end

# Define several provider
C3po.configure do |config|
  config.provider = [:google, :bing]
  config.google_api_key = "MYAPIKEY"
  config.bing_api_key = "MYAPIKEY"
end

# Let's translate
translator = C3po.new('I want this droid to be translated')
translator.translate(:en, :fr) # =>
translator.is # => :en
translator.is?(:de) # => false
```

Todo
----

* More specs
* Use it

Copyright
---------

See LICENSE for further details.
