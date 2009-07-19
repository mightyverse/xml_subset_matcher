Gem::Specification.new do |s|
  s.name = %q{xml_subset_matcher}
  s.version = "0.0.5"
  s.date = %q{2009-07-13}
  s.authors = ["Wolfram Arnold, Sarah Allen"]
  s.email = %q{wolfram@rubyfocus.biz, sarah@ultrasaurus.com}
  s.summary = %q{XmlSubsetMatcher provides utitlity methods for comparing xml documents.}
  s.homepage = %q{http://TBD - github page/}
  s.description = %q{XmlSubsetMatcher provides utitlity methods for comparing xml documents.  Whitespace is ignored and the order of nodes or attributes doesn't matter. It will return true of all the nodes and subnodes and their attributes are present in the superset.}
  s.files = [ "README", "MIT-LICENSE", "lib/xml_subset_matcher.rb", "spec/lib/xml_subset_matcher_spec.rb"]
end

