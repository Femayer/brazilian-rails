# Códigos de serviço dos correios
# 41106 PAC sem contrato
# 40010 SEDEX sem contrato
# 40045 SEDEX a Cobrar, sem contrato
# 40215 SEDEX 10, sem contrato
# 40290 SEDEX Hoje, sem contrato
# 40096 SEDEX com contrato
# 40436 SEDEX com contrato
# 40444 SEDEX com contrato
# 81019 e-SEDEX, com contrato
# 41068 PAC com contrato

SERVICOS = {:pac => "41109", :sedex => "40010", :sedex_a_cobrar => "40045", :sedex_10 => "40215", :sedex_hoje => "40290",
	:sedex_contrato => "40096", :esedex => "81019", :pac_contrato => "41068" }

require 'rubygems'
require 'net/http'

gem 'soap4r'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(default defaultDriver defaultMappingRegistry).each {|req| require File.dirname(__FILE__) + "/brfrete/#{req}"}

URL_W21STUDIO = "http://frete.w21studio.com/calFrete.xml?"
URL_CORREIOS = "http://shopping.correios.com.br/wbm/shopping/script/CalcPrecoPrazo.aspx"

module BrFrete	
  def self.valor_do_sedex options
		options[:servico] = SERVICOS[:sedex] unless options[:servico]
	  response = Net::HTTP.get_response(URI.parse("#{URL_CORREIOS}?strRetorno=xml&nCdServico=#{options[:servico]}&nVlPeso=#{options[:peso]}&sCepOrigem=#{options[:de]}&sCepDestino=#{options[:para]}&nCdFormato=1&sCdMaoPropria=N&sCdAvisoRecebimento=N&nVlValorDeclarado=0"))
	
		valor = response.body.match("<Valor>(.*)</Valor>")[1].gsub(",",".").to_f
		erro = response.body.match("<Erro>(.*)</Erro>")[1]
		raise ArgumentError.new("Erro: #{erro}") unless erro == "0"
		valor
	end
	
	#TODO deixar dimensoes menos hard coded. Serve para cálculos básicos.
	def self.valor_do_frete options
		url = "#{URL_W21STUDIO}cep=#{options[:para]}&peso=#{options[:peso]}&cod=#{options[:de]}&comprimento=20&largura=20&altura=20&servico=3"
		response = Net::HTTP.get_response(URI.parse(url))
		response.body.match("<valor_sedex>(.*)</valor_sedex>")[1].to_f
	end
end