class VersionAdapter
  class << self
    def string_to_array version
      return [] unless version.is_a? String

      version.split('.').map(&:to_i)
    end

    def array_to_string version
      return '' unless version.is_a? Array

      version.join '.'
    end
  end
end
