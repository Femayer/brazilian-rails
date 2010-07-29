require 'net/http'

class BuscaValorFrete
  @@cep_origem_padrao = nil
  
  FRETE_PARAMS = {
    :tipo => {:sedex => 40010, :pac => 41106},
    :url => Proc.new {|options| "http://shopping.correios.com.br/wbm/shopping/script/CalcPrecoPrazo.aspx?nCdEmpresa=&sDsSenha=&sCepOrigem=#{options[:de]}&sCepDestino=#{options[:para]}&nVlPeso=#{options[:peso]}&nCdFormato=1&nVlComprimento=#{options[:comprimento]}&nVlAltura=#{options[:altura]}&nVlLargura=#{options[:largura]}&sCdMaoPropria=n&nVlValorDeclarado=0&sCdAvisoRecebimento=n&nCdServico=#{FRETE_PARAMS[:tipo][options[:tipo]]}&nVlDiametro=0&StrRetorno=xml" },
    :match => {:valor => '<Valor>(.*)</Valor>', :erro => '<Erro>(.*)</Erro>'}
  }

  
  class << self
    def cep_origem_padrao
      @@cep_origem_padrao
    end

    def cep_origem_padrao=(cep)
      @@cep_origem_padrao=cep
    end
  end
  
  def self.por_pac(options)
    self.por :pac, options
  end
  
  def self.por_sedex(options)
    self.por :sedex, options
  end
  
  def self.por(tipo, options)
    valor = nil
    options = setar_valores_default(options).merge(:tipo => tipo)
    
    begin
      url = FRETE_PARAMS[:url].call(options)
      response = Net::HTTP.get_response(URI.parse( url ))
      
      # TODO: ver o que fazer quando um erro ocorre
      erro  = response.body.match(FRETE_PARAMS[:match][options[:erro]])[1].to_i
      valor = response.body.match(FRETE_PARAMS[:match][options[:valor]])[1].gsub(",", ".").to_f
    rescue
      valor = 0
    end
    valor
  end
  
  private 
    def self.setar_valores_default(options)
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