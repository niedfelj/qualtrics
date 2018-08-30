# https://github.com/digitalocean/kartograph/pull/11
# adds the ability to define properties as optional

module Kartograph
  class Artist
    def build_properties(object, scope, *args)
      scoped_properties = scope ? properties.filter_by_scope(scope) : properties
      scoped_properties.each_with_object({}) do |property, mapped|
        raise ArgumentError, "#{object} does not respond to #{property.name}, so we can't map it" unless object.respond_to?(property.name)

        mapped[property.key] = property.value_for(object, scope) unless property.value_for(object, scope).nil? && property.optional?
      end
    end
  end

  class Property
    def optional?
      !!options[:optional]
    end
  end
end
