module MyVk
  class Factory
    
    def self.factory(name)
      #res = class_exists_in_base?(name.capitalize)
      #if res
      #  res.get
      #else
        Object.const_get('MyVk').const_get('Instances').const_get(name.capitalize).new
      #end
    
      #Object.const_get('ActiveRecord').const_get('Base').const_get('qqq'.capitalize).
      #Object.const_get('MyVk').const_get('Instances').const_get(name.capitalize).new
    end
    
    private 
    def self.class_exists_in_base?(name)
      begin
        res = Object.const_get('MyVk').const_get('Instances').const_get(name.capitalize)
        res if res
      rescue NameError
        false
      end
    end
  end
end