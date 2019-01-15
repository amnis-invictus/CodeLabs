class Archive::ExampleParser
  class << self
    def attributes xml
      { id: xml[:id], _destroy: xml[:_destroy], input: xml[:input], answer: xml[:answer] }.compact
    end
  end
end
