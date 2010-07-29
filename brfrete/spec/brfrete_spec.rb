require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'brfrete'

describe "BrFrete" do
	
	  it "o preco de sedex dentro de são paulo tem que ser maior que zero e menor que 30" do
		valor = BrFrete.valor_do_sedex :de => "01229010", :para => "04543000", :peso => 1
		valor.should > 0
		valor.should < 30
	end
	
	it "deve lancar excessao quando o cep está errado" do
		lambda { BrFrete.valor_do_sedex :de => "00000000", :para => "04543000", :peso => 1 }.should raise_error(ArgumentError)		
	end
	
	it "deve lancar excessao quando o peso é muito grande" do
		lambda { BrFrete.valor_do_sedex :de => "01229010", :para => "04543000", :peso => 1000 }.should raise_error(ArgumentError)		
	end
	
	it "deve calcular o frete usando o serviço do w21studio" do
	  valor = BrFrete.valor_do_frete :de => "2702", :para => "04543000", :peso => 1
		valor.should > 0
		valor.should < 30
	end

end
