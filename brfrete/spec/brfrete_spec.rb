require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'brfrete'

describe "BrFrete" do
	
	  it "o preco de sedex de 01229010 para 18260000 deve ser R$13,40" do
		valor = BrFrete.valor_do_sedex :de => "01229010", :para => "18260000", :peso => 1
		valor.should == 13.4
	end
	
	it "deve lancar excessao quando o cep está errado" do
		lambda { BrFrete.valor_do_sedex :de => "00000000", :para => "04543000", :peso => 1 }.should raise_error(ArgumentError)		
	end
	
	it "deve lancar excessao quando o peso é muito grande" do
		lambda { BrFrete.valor_do_sedex :de => "01229010", :para => "04543000", :peso => 1000 }.should raise_error(ArgumentError)		
	end
	
	it "deve calcular o frete usando o serviço do w21studio" do
		BuscaFrete.servico_padrao = :w21studio
	  valor = BrFrete.valor_do_frete :de => "2702", :para => "04543000", :peso => 1
		valor.should > 0
		valor.should < 30
	end

end
