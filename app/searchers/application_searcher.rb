class ApplicationSearcher
  attr_reader :relation, :params

  def initialize relation, params = {}
    @relation = relation

    @params = params
  end

  def search
    return relation unless params

    conditions = params.to_unsafe_hash.map do |attribute, value|
      method_name = :"search_by_#{ attribute }"

      send method_name, value if respond_to? method_name, true
    end

    conditions.compact.reduce(:merge) || relation
  end

  class << self
    def search *args
      new(*args).search
    end
  end
end
