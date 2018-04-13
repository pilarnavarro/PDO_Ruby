#encoding: utf-8
require_relative 'ShieldToUI'
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
    
    def getUIversion
      return ShieldToUI.new(self)
    end
    
    def to_s
      aux="\t\tNombre: #{name} \tPotencia: #{boost} \tNúmero de usos de que dispone: #{uses}\n\n"
      return aux
    end
  end
end