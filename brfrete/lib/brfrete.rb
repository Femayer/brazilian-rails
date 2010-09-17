$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(busca_frete version).each {|req| require File.dirname(__FILE__) + "/brfrete/#{req}"}


#require 'rubygems'

module BrFrete
	def self.valor_do_sedex(options)
		BuscaFrete.valor_sedex(options)
	end
	
	def self.valor_do_frete options
		BuscaFrete.valor_sedex(options)
	end
  
end