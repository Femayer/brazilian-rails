class Frete
  def self.valor_do_sedex options
		correios = Correios.new(options[:de], options[:para], options[:peso], nil, 40096)
		sedex = FreteSoap.new.correios(correios).correiosResult.to_f
	end
	
	def self.valor_do_esedex options
		correios = Correios.new(options[:de], options[:para], options[:peso], nil, 81019)
		sedex = FreteSoap.new.correios(correios).correiosResult.to_f
	end
end