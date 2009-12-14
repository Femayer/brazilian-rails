require 'rubygems'
require 'net/http'

gem 'soap4r'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(default defaultDriver defaultMappingRegistry).each {|req| require File.dirname(__FILE__) + "/brfrete/#{req}"}

URL_W21STUDIO = "http://frete.w21studio.com/calFrete.xml?"

module BrFrete	
  def self.valor_do_sedex options
		par = CalcPrecoPrazo.new(nil, nil, 40010, options[:de], options[:para], options[:peso])
		servico = CalcPrecoPrazoWSSoap.new.calcPrecoPrazo(par).calcPrecoPrazoResult.servicos[0]
		raise ArgumentError.new("#{servico.erro}: #{servico.msgErro}") unless servico.erro =
		servico.valor.to_f
	end
	
	#TODO deixar dimensoes menos hard coded. Serve para cálculos básicos.
	def self.valor_do_frete options
		response = Net::HTTP.get_response(URI.parse("#{URL_W21STUDIO}cep=#{options[:para]}&peso=#{options[:peso]}&cod=#{options[:de]}&comprimento=20&largura=20&altura=20&servico=3"))
		response.body.match("<valor_sedex>(.*)</valor_sedex>")[1].to_f
	end
	
end