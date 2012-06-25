require 'ooor'
require 'ooor/finders/dynamic_finder_match'
module Ooor
  class OpenObjectResource
    class << self
      alias_method :method_missing_original, :method_missing

      def _instanciate_by_attributes(match, arguments)
        # TODO check relation and send a warning
        res = self.new
        if RUBY_VERSION  >= '1.9.0' # related to system stack level error
          res.id = nil
        end
        attributes = match.attribute_names
        xml_id = nil
        attributes.length.times do |index|
          if ['xml_id', 'oid'].include? attributes[index]
            xml_id = arguments[index]
          elsif attributes[index] == 'id'
            raise "find_or_create_by_id is not supported"
          else
            eval("res.#{attributes[index]} = arguments[index]")
          end
        end
        if xml_id
          res.ir_model_data_id = xml_id.split('.')
        end
        if match.instantiator == :create
          res.save
        end
        return res
      end

      def _find_or_instantiator_by_attributes(match, arguments)
        unique_keys = ['xml_id', 'id', 'oid']
        options = {}
        if arguments.last.is_a? Hash
          options = arguments.last
        end
        attributes = match.attribute_names
        unique_index = attributes.index{|x| unique_keys.include? x}
        if unique_index
          res = self.find(arguments[unique_index], options)
        else
          domain = []
          attributes.length.times do | index |
            domain.push([attributes[index] ,'=', arguments[index]])
          end
          options.merge!({:domain => domain})
          res = self.find(match.finder, options)
          if match.bang? && !match.instantiator?
            unless res
              raise "Could not find #{self.class} with for domain #{domain.inspect}"
            end
          end
        end
        if match.instantiator and not res
          return _instanciate_by_attributes(match, arguments)
        end
        return res
      end

      def method_missing(method_symbol, *arguments)
        match = DynamicFinderMatch.match(method_symbol.to_s)
        if match
          return send(:_find_or_instantiator_by_attributes, match, arguments)
        end
        return method_missing_original(method_symbol, *arguments)
      end
    end
  end
end
