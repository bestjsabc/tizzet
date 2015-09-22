module Refinery

  class << self
    attr_accessor :is_a_gem, :root, :s3_backend
    def is_a_gem
      @is_a_gem ||= false
    end

    def root
      @root ||= Pathname.new(File.dirname(__FILE__).split("vendor").first.to_s)
    end

    def s3_backend
      @s3_backend ||= false
    end
  end

end
