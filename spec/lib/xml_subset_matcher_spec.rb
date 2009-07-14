# (c) 2009 Mightyverse, Inc.  Use is subject to license terms.
require File.dirname(__FILE__) + '/../spec_helper'
require 'nokogiri'

describe 'XmlSubsetMatcher' do
  it 'should match on nodes of the same name' do
    subset = "<phrase />"
    superset = "<phrase />"
    subset.should be_xml_subset_of(superset)
  end

  it 'should fail on nodes of differnt names' do
    subset = "<phrase />"
    superset = "<satz />"
    subset.should_not be_xml_subset_of(superset)
  end

  it 'should match content of nodes' do
    subset = "<phrase>Yadi Yada</phrase>"
    superset = "<phrase>Yadi Yada</phrase>"
    subset.should be_xml_subset_of(superset)
  end

  it 'should fail if content of nodes of same name differs' do
    subset = "<phrase>Yadi Yada</phrase>"
    superset = "<phrase>Hallo Welt!</phrase>"
    subset.should_not be_xml_subset_of(superset)
  end

  it 'should match on nested nodes of the same name' do
    subset = "<phrase><uuid>aaa</uuid></phrase>"
    superset = "<phrase><uuid>aaa</uuid></phrase>"
    subset.should be_xml_subset_of(superset)
  end

  it 'should fail on different children of the same top-level name' do
    subset = "<phrase><locale></locale></phrase>"
    superset = "<phrase><uuid></uuid></phrase>"
    subset.should_not be_xml_subset_of(superset)
  end

  it 'should fail on same children of the different top-level name' do
    subset = "<phrase><uuid></uuid></phrase>"
    superset = "<satz><uuid></uuid></satz>"
    subset.should_not be_xml_subset_of(superset)
  end

  it 'should match a subset of children' do
    subset = "<phrase><uuid>sss</uuid></phrase>"
    superset = "<phrase><locale>xxx</locale><uuid>sss</uuid></phrase>"
    subset.should be_xml_subset_of(superset)
  end

  it 'should fail if superset is a subset' do
    superset = "<phrase></phrase>"
    false_subset = "<phrase><locale /><uuid>aaa</uuid></phrase>"
    false_subset.should_not be_xml_subset_of(superset)
  end

  it 'should not care about white space' do
    subset = <<-EOS
      <phrase>
      <text>Source</text>
      </phrase>
    EOS
    superset = <<-EOS
      <phrase>      <text>Source</text>
      </phrase>
    EOS
    subset.should be_xml_subset_of(superset)
  end

  it 'should not care about blank lines' do
    subset = <<-EOS
      <phrase>

      <text>Source</text>
      </phrase>
    EOS
    superset = <<-EOS
      <phrase>
      <text>Source</text>
      </phrase>
    EOS
    subset.should be_xml_subset_of(superset)
  end

  it 'should pass a real life example' do
    subset = <<-EOS
        <?xml version="1.0"?>
        <phrase>
            <uuid>060e985b-0307-4c8f-b43f-c16f0e45196d</uuid>
            <source_text>Fake Catalan Source</source_text>
            <text />
        </phrase>
    EOS
    superset = <<-EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <phrase>
        <uuid>060e985b-0307-4c8f-b43f-c16f0e45196d</uuid>
        <created_at type="datetime">2009-04-21T06:22:07Z</created_at>
        <text nil="true"/>
        <updated_at type="datetime">2009-04-21T06:22:07Z</updated_at>
        <source_text>Fake Catalan Source</source_text>
        <phonetic_transcription nil="true"/>
        <media type="array"/>
      </phrase>
    EOS
    subset.should be_xml_subset_of(superset)
  end

  it 'should handle multiple siblings of the same name when in the same order' do
    subset = <<-EOS
      <phrase>
        <text>Source</text>
        <text>Something</text>
        <text />
      </phrase>
    EOS
    superset = <<-EOS
      <phrase>
        <text>Source</text>
        <text>Something</text>
        <text /> <text>extra</text>   
      </phrase>
    EOS
    subset.should be_xml_subset_of(superset)
  end

  it 'should handle multiple siblings of the same name when in different order' do
    subset = <<-EOS
      <phrase>
        <text>Source</text>
        <text>Something</text>
        <text />
      </phrase>
    EOS
    superset = <<-EOS
      <phrase>
        <text />
        <text>Something</text>
        <text>Source</text>
      </phrase>
    EOS
    subset.should be_xml_subset_of(superset)
  end

  it 'should ignore comments in the subset' do
    subset = <<-EOS
      <!-- comment -->
      <phrase>
        <!-- ignore this -->
        <text>Source</text>
        <text>Something</text>
        <text />
      </phrase>
      <!-- and this too -->
    EOS
    superset = <<-EOS
      <phrase>
        <text />
        <text>Something</text>
        <text>Source</text>
      </phrase>
    EOS
    subset.should be_xml_subset_of(superset)
  end

  it 'should ignore comments in the superset' do
    subset = <<-EOS
      <phrase>
        <text>Source</text>
        <text>Something</text>
        <text />
      </phrase>
    EOS
      superset = <<-EOS
      <!-- ignore this -->
      <phrase>
        <!-- and this too -->
        <text />
        <text>Something</text>
        <text>Source</text>
      </phrase>
    EOS
      subset.should be_xml_subset_of(superset)
  end
end
