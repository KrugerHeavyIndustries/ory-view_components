# frozen_string_literal: true

module Ory
  module ClassNameHelper
    def class_names(*args)
      classes = []
      args.each do |arg|
        case arg
        when String
          classes << arg unless arg.empty?
        when Hash
          arg.each { |cls, condition| classes << cls.to_s if condition }
        when Array
          classes.concat(class_names(*arg).split(" "))
        end
      end
      classes.join(" ")
    end
  end
end
