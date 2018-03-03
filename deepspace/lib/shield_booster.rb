module Deepspace
  class ShieldBooster
    def initialize(name,boost,uses)
      @name=name #String
      @boost=boost #float
      @uses=uses  #int
    end

    def self.newCopy(copy)
      new(copy.name,copy.boost,copy.uses)
    end

    def name
      @name
    end

    def boost
      @boost
    end

    def uses
      @uses
    end

    def useIt
      if @uses>0
        @uses-=1
        self.boost
      else
        return 1.0
      end
    end

  end
end