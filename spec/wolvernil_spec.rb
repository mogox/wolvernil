# frozen_string_literal: true

RSpec.describe Wolvernil do
  it "has a version number" do
    expect(Wolvernil::VERSION).not_to be nil
  end

  it "does something experimental" do
    methods_size = nil.methods.count
    nil.extend(Wolvernil)
    new_methods_size = nil.methods.count
    expect(new_methods_size > methods_size).to be true
  end
end
