# encoding: UTF-8
require 'rubygems'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/brfrete'
require 'net/http'

class BuscaFreteTest < Test::Unit::TestCase
  def test_raise_for_invalid_zip_code
    assert_raise(RuntimeError) do 
      BuscaFrete.valor_pac(:para => '9988')
    end
  end    
  
  def test_valid_code_with_origem_in_parameter
    assert_equal(11.5, BuscaFrete.valor_pac(:de => '95670000', :para => '91030080'))
  end

  def test_valid_code_with_origem_padrao
    BuscaFrete.cep_origem_padrao = '95670000'
    assert_equal(11.5, BuscaFrete.valor_pac(:para => '91030080'))
  end
end
