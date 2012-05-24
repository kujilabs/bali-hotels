require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])



module BaliEnv
  def self.prefix
    "BALI_#{Rails.env.upcase}_"
  end
  
  def self.[](name)
    ENV[name] || ENV["BALI_#{name}"] || ENV["#{prefix}#{name}"]
  end
  
  def self.[]=(name, value)
    ENV["#{prefix}#{name}"] = value
  end
end
BALI_ENV = BaliEnv

module BaliSafeEnv
  def self.[](name)
    BALI_ENV[name].tap{ |value| raise "Must set environment variable #{BaliEnv.prefix}#{name}" unless value.to_s.length > 0 }
  end
  
  def self.[]=(name, value)
    BALI_ENV[name] = value
  end
end
BALI_SAFE_ENV = BaliSafeEnv


module SafeEnv
  def self.[](name)
    ENV[name].tap{ |value| raise "Must set environment variable #{name}" unless value.to_s.length > 0 }
  end
end
SAFE_ENV = SafeEnv