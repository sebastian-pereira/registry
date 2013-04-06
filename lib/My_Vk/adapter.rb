module MyVk
  
  class Adapter
    attr_accessor :controller
    
    def initialize(controller)
      self.controller = controller
    end
    
    def cookies
      controller.send(:cookies)
    end
    
    def session
      controller.send(:session)
    end
    
    def params
      controller.send(:params)
    end
    
    def request
      controller.send(:request)
    end
    
    
    module Implementation
      def self.included(klass)
        klass.prepend_before_filter :activate
      end
      
      private
      def activate
        MyVk::Environment.getInstance.controller = Adapter.new(self)
      end
      
    end
  end
end