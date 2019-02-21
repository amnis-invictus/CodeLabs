class ApplicationFactory
  class << self
    def build *args
      new(*args).build
    end
  end
end
