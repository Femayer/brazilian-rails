require 'rubygems'
gem 'soap4r'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(default defaultDriver).each {|req| require File.dirname(__FILE__) + "/brfrete/#{req}"}


module BrFrete	
	def self.valor_do_sedex(options = {})
		correios = Correios.new(options[:de], options[:para], options[:peso], nil, 40096)
		sedex = FreteSoap.new.correios(correios).correiosResult.to_f
	end
	
	def self.valor_do_esedex(options = {})
		correios = Correios.new(options[:de], options[:para], options[:peso], nil, 81019)
		sedex = FreteSoap.new.correios(correios).correiosResult.to_f
	end
end