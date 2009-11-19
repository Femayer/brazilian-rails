require File.dirname(__FILE__) + '/../../spec_helper'
require 'chronic'

describe BrCobranca::BrCartao do
  
	it "deve retornar o numero de filiacao formatado corretamente" do
	  BrCobranca::BrCartao.num_filiacao_formatado("1001734898").should == "73489"
	  BrCobranca::BrCartao.num_filiacao_formatado("1001696998").should == "69699"
	end
	
	it "codigo pagamento deve estar correto" do
	  BrCobranca::BrCartao.codigo_pagamento(:a_vista, 1).should == "1001"
	  BrCobranca::BrCartao.codigo_pagamento(:juros_lojista, 2).should == "2002"
	  BrCobranca::BrCartao.codigo_pagamento(:juros_lojista, 3).should == "2003"
	  BrCobranca::BrCartao.codigo_pagamento(:juros_emissor, 3).should == "3003"
	  BrCobranca::BrCartao.codigo_pagamento(:debito, 1).should == "A001"
	end
	
	it "o tid deve ser a retornado corretamente" do
	  #tid = filiacao_formatado + ult. digito ano + datajuliana + hhmmssd + codigo_pagamento
		Time.should_receive(:new).and_return(Time.parse("01/01/2009 07:08:09"))
		BrCobranca::BrCartao.tid("1001734898", :juros_lojista, 2).should == "73489900107080902002"
		Time.should_receive(:new).and_return(Time.parse("02/01/2008 23:59:59.2"))
		BrCobranca::BrCartao.tid("1001666668", :juros_emissor, 6).should == "66666803223595923006"
	end
end