require 'net/http'

class BuscaFrete
  @@cep_origem_padrao = nil
  
  FRETE_PARAMS = {
    :tipo => {:sedex => 40010, :pac => 41106},
    :url => Proc.new {|options| "http://shopping.correios.com.br/wbm/shopping/script/CalcPrecoPrazo.aspx?nCdEmpresa=&sDsSenha=&sCepOrigem=#{options[:de]}&sCepDestino=#{options[:para]}&nVlPeso=#{options[:peso]}&nCdFormato=1&nVlComprimento=#{options[:comprimento]}&nVlAltura=#{options[:altura]}&nVlLargura=#{options[:largura]}&sCdMaoPropria=n&nVlValorDeclarado=0&sCdAvisoRecebimento=n&nCdServico=#{FRETE_PARAMS[:tipo][options[:tipo]]}&nVlDiametro=0&StrRetorno=xml" },
    :match => {:valor => '<Valor>(.*)</Valor>', :erro => '<Erro>(.*)</Erro>', :erro_mensagem => '<MsgErro>(.*)</MsgErro>'}
  }

  
  class << self
    def cep_origem_padrao
      @@cep_origem_padrao
    end

    def cep_origem_padrao=(cep)
      @@cep_origem_padrao=cep
    end
  end
  
  def self.valor_pac(options)
    self.valor :pac, options
  end
  
  def self.valor_sedex(options)
    self.valor :sedex, options
  end
  
  def self.valor(tipo, options)
    options = setar_parametros_default(options).merge(:tipo => tipo)
    
    begin
      url = FRETE_PARAMS[:url].call(options)
      response = Net::HTTP.get_response(URI.parse( url )).body
      
      erro = response.match(FRETE_PARAMS[:match][:erro])[1].to_i
      raise "#{response.match(FRETE_PARAMS[:match][:erro_mensagem])[1]}" if erro != 0
      
      response.match(FRETE_PARAMS[:match][:valor])[1].gsub(",", ".").to_f
    end
  end
  
  private 
    def self.setar_parametros_default(options)
      options[:de] = @@cep_origem_padrao if options[:de].nil?
      options[:peso] = 1 if options[:peso].nil?
      options[:comprimento] = 20 if options[:comprimento].nil?
      options[:largura] = 20 if options[:largura].nil?
      options[:altura] = 20 if options[:altura].nil?

      #Arredonda o peso para cima
      options[:peso] = options[:peso].ceil
      options
    end
  
end