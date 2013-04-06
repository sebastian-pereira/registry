module MyVk
  
  class Registry
    @@variables = Hash.new
    
    def get(key)
      @@variables[key] || nil
    end
    
    def set(key, value)
      @@variables[key] = value
    end
    
    def unset(key)
      @@variables.delete key
    end
    
    def include?(key)
      @@variables.keys.include?(key) ? true : false
    end
    
    def changed?(key)
      var = @@variables[key]
      if var == nil || var.changed?
        true 
      else
        false
        
      end
    end
  end

  class Environment
    attr_accessor :controller
    #def controller=(controller); @controller = controller; end;
    
    @@instance = nil
    def self.getInstance
      if @@instance == nil
        @@instance = self.new
      end
      @@instance
    end
    
    def initialize
      @registry = Registry.new
      @controller = nil
    end
    
    def registry; @registry; end
    
    def get(key)
      if @registry.include?(key) && !@registry.changed?(key)
        return @registry.get(key).get
      else
        var = MyVk::Factory.factory(key)
        @registry.set(key, var)
        return var.get
      end
    end
    
    def set(key, value)
      instance = MyVk::Factory.factory(key)
      instance.set(value)
      
      if value == nil
        @registry.unset key
      else
        @registry.set(key, instance)
      end
    end
  end
end