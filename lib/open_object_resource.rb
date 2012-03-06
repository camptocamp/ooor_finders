require 'rubygems'
require 'ooor'

module Ooor
  class OpenObjectResource
    class << self
      alias_method :method_missing_original, :method_missing
      
      def _dynamic_find(match, arguments)
        options = {}
        if arguments.last.is_a? Hash
          options = arguments.last
        end
        attributes = match.attribute_names
        if attributes[0] == 'xml_id' || attributes[0] == 'id' || attributes[0] == 'oid'
          return self.find(arguments[0], options)
        else
          domain = []
          attributes.length.times do | index |
            domain.push([attributes[index] ,'=', arguments[index]])
          end
          options.merge!({:domain => domain})
          res = self.find(match.finder, options)
          if match.bang?
            unless res
              raise "Could not find #{self.class} with for domain #{domain.inspect}"
            end
          end
          return res
        end
      end
      
      def method_missing(method_symbol, *arguments)
        match = DynamicFinderMatch.match(method_symbol.to_s)
        if match
          return send(:_dynamic_find, match, arguments)
        end
        return method_missing_original
      end
    end
  end
end