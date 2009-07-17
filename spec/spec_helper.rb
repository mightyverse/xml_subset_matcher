# -*- encoding: utf-8 -*-

$:.push File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'xml_subset_matcher'

Spec::Runner.configure do |config|
  config.include(XmlSubsetMatcher)
end
# see http://sameshirteveryday.com/2007/09/15/rspec-custom-expectation-matcher-example/

