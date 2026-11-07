# frozen_string_literal: true

module WelcomeHelper
  # Flattens nested identity traits into dotted keys, e.g. name.first.
  def flatten_traits(traits, prefix = nil)
    traits.to_h.flat_map do |key, value|
      name = [prefix, key].compact.join(".")
      value.is_a?(Hash) ? flatten_traits(value, name) : [[name, value]]
    end
  end

  def session_time(time)
    return "—" unless time

    relative = time.past? ? "#{time_ago_in_words(time)} ago" : "in #{time_ago_in_words(time)}"
    tag.time("#{time.to_fs(:long)} (#{relative})", datetime: time.iso8601)
  end
end
