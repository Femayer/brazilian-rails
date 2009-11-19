module BrCobranca::BrCartao
	
	TIPO_DE_PAGAMENTOS = {:a_vista => "10", :juros_lojista => "20", :juros_emissor => "30", :debito => "A0"}
	
	def tid afiliacao, numero_de_parcelas, tipo_de_pagamento
		
	end
	
	def self.num_filiacao_formatado num_filiacao
		num_filiacao[4,5]
	end
	
	def self.codigo_pagamento tipo, parcelas
		"#{TIPO_DE_PAGAMENTOS[tipo]}#{"%02d" % parcelas}"
	end
	
	def self.tid num, tipo, parcelas
		date = Time.new
		ano = date.year.to_s[-1..-1]
		"#{num_filiacao_formatado(num)}#{ano}#{date.strftime("%j%H%M%S")}0#{codigo_pagamento(tipo, parcelas)}"
	end
	
end