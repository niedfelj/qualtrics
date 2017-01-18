require "virtus"

module Qualtrics::API
  class BaseModel
    include Virtus.model
    include Virtus::Equalizer.new(name || inspect)
    include ::ActiveModel::Serialization

    def inspect
      values = Hash[instance_variables.map { |name| [name, instance_variable_get(name)] }]
      "<#{self.class.name} #{values}>"
    end
  end
end
