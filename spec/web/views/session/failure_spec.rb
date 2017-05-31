require 'spec_helper'
require_relative '../../../../apps/web/views/session/failure'

describe Web::Views::Session::Failure do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/session/failure.html.erb') }
  let(:view)      { Web::Views::Session::Failure.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    skip 'This is an auto-generated test. Edit it and add your own tests.'

    # Example
    view.foo.must_equal exposures.fetch(:foo)
  end
end
