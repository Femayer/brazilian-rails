# encoding: UTF-8
require 'rubygems'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/brfrete'
require 'net/http'

#http://frete.w21studio.com/calFrete.xml?cep=72600000&cod=1000&peso=10&comprimento=60&largura=60&altura=5&servico=3

class BuscaFreteTest < Test::Unit::TestCase
  def test_raise_for_invalid_zip_code
    BuscaFrete.servico_padrao = :w21studio
    assert_raise(RuntimeError) do 
      BuscaFrete.valor_pac(:para => '9988')
    end
  end    
  
  def test_valid_code_with_origem_in_parameter_for_w21studio
    BuscaFrete.servico_padrao = :w21studio
    assert_equal(12.30, BuscaFrete.valor_pac(:de => 2355, :para => '91030-080'))
    assert_equal(12.80, BuscaFrete.valor_sedex(:de => 2355, :para => '91030-080'))
    assert_equal(12.30, BuscaFrete.valor_pac(:de => 2355, :para => '91030080'))
    assert_equal(12.80, BuscaFrete.valor_sedex(:de => 2355, :para => '91030080'))
  end

  def test_valid_code_with_origem_padrao_for_w21studio
    BuscaFrete.servico_padrao = :w21studio
    BuscaFrete.cep_origem_padrao = 2355
    assert_equal(12.30, BuscaFrete.valor_pac(:para => '91030080'))
    assert_equal(12.30, BuscaFrete.valor_pac(:para => '91030-080'))
    assert_equal(12.80, BuscaFrete.valor_sedex(:para => '91030080'))
    assert_equal(12.80, BuscaFrete.valor_sedex(:para => '91030-080'))
  end
  
  
  def test_valid_code_with_origem_in_parameter_for_correios
    BuscaFrete.servico_padrao = :correios
    assert_equal(11.5, BuscaFrete.valor_pac(:de => '95670000', :para => '91030080'))
    assert_equal(13.4, BuscaFrete.valor_sedex(:de => '95670000', :para => '91030080'))
  end

  def test_valid_code_with_origem_padrao_for_correios
    BuscaFrete.servico_padrao = :correios
    BuscaFrete.cep_origem_padrao = '95670000'
    assert_equal(11.5, BuscaFrete.valor_pac(:para => '91030080'))
    assert_equal(13.4, BuscaFrete.valor_sedex(:para => '91030080'))
  end

end
