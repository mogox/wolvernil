# frozen_string_literal: true

require_relative "wolvernil/version"
require_relative "wolvernil/nil_tracker"

module Wolvernil
  def method_missing(method, *args, &block)
    return if method == :call

    nil_tracker.log(method, caller.take(5).join("\n"), args, block)

    if raise_exception?
      error_message = "=====> Trying to call method `#{method}` nil (NoMethodError)"
      puts "====> Raising NoMethodError <=====\n\n"
      raise NoMethodError.new(error_message)
    else
      puts "=====> NoMethodError not raised for method #{method}"
      puts "================================\n\n"
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    false
  end

    def raise_exception?
    nil_tracker.raise_exception
  end

  def raise_exception(value)
    nil_tracker.raise_exception = value
  end

  def self.methods_list
    NilTracker.instance.methods_list
  end

  def to_ary
    []
  end

  def to_h
    {}
  end

  def to_hash
    {}
  end

  def to_str
    ""
  end

  def []=(key, value)
  end

  def process_wait
    super
  end

  def call(*args)
    super(args)
  end

  def permitted?
    false
  end

  private

  def nil_tracker
    Wolvernil::NilTracker.instance
  end

  class Error < StandardError; end
end
