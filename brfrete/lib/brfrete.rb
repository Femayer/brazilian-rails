require 'rubygems'
gem 'soap4r'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(default defaultDriver defaultMappingRegistry).each {|req| require File.dirname(__FILE__) + "/brfrete/#{req}"}


module BrFrete	
  def self.valor_do_sedex options
		par = CalcPrecoPrazo.new(nil, nil, 40010, options[:de], options[:para], options[:peso])
		servico = CalcPrecoPrazoWSSoap.new.calcPrecoPrazo(par).calcPrecoPrazoResult.servicos[0]
		raise ArgumentError.new("#{servico.erro}: #{servico.msgErro}") unless servico.erro =
		servico.valor.to_f
	end
	
end