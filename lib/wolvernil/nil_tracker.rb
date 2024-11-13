require "singleton"

module Wolvernil
  class NilTracker
    include Singleton

    attr_accessor :raise_exception

    def methods_list
      @methods_list ||= {}
    end

    def log(method, caller_lines, *args, &block)
      error_message = "=====> Trying to call method **#{method}** in `nil` (NoMethodError)"

      puts error_message
      puts "=====> Caller: (stacktrace)"
      puts caller.take(5).join("\n")
      puts "=====> args: #{args}" if args&.size&.> 0
      puts "=====> block: #{block.source}" if block

      create_method(method, args, block)
      store_method_info(method, caller_lines, args, block)
    end

    def create_method(method, *args, &block)
      return if methods_list[method]

      Wolvernil.define_method(method) do |*args, &block|
        p "---> Calling a method #{method} in the nil class, this has been logged"
      end
    end

    def store_method_info(method, caller_lines, *args, &block)
      new_block = args[1].source if args[1]&.class == Proc
      methods_list[method] = {
        args: args,
        block: new_block,
        caller_lines: caller_lines,
        timestamp: Time.now
      }
    end
  end
end
