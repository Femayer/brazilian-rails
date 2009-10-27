require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'brfrete'

describe "BrFrete" do

	it "o preco do sedex deve ser mais caro que o do eSedex" do
		sedex = BrFrete.valor_do_sedex :de => "01229010", :para => "04543000", :peso => 1
		esedex = BrFrete.valor_do_esedex :de => "01229010", :para => "04543000", :peso => 1
		sedex.to_f.should > esedex.to_f
	end
	
  it "o preco de sedex dentro de são paulo tem que ser maior que zero e menor que 30" do
		valor = BrFrete.valor_do_sedex :de => "01229010", :para => "04543000", :peso => 1
		valor.should > 0
		valor.should < 30
	end

end
