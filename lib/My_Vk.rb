require "active_support/dependencies"

['environment', 'adapter', 'factory', 'version', 'instances/instance', 'instances/user', 'instances/model'].each do |file|
  require File.dirname(__FILE__) + "/My_Vk/" + file
end

module Env
  def self.get(key)
    MyVk::Environment.getInstance.get(key)
  end
  
  def self.set(key, value)
    MyVk::Environment.getInstance.set(key, value)
  end
end

ActionController::Base.send(:include, MyVk::Adapter::Implementation)