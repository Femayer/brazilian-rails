require 'xsd/qname'

# {http://tempuri.org/}Correios
#   cepOrigem - SOAP::SOAPString
#   cepDestino - SOAP::SOAPString
#   peso - SOAP::SOAPString
#   volume - SOAP::SOAPString
#   codigo - SOAP::SOAPString
class Correios
  attr_accessor :cepOrigem
  attr_accessor :cepDestino
  attr_accessor :peso
  attr_accessor :volume
  attr_accessor :codigo

  def initialize(cepOrigem = nil, cepDestino = nil, peso = nil, volume = nil, codigo = nil)
    @cepOrigem = cepOrigem
    @cepDestino = cepDestino
    @peso = peso
    @volume = volume
    @codigo = codigo
  end
end

# {http://tempuri.org/}CorreiosResponse
#   correiosResult - SOAP::SOAPString
class CorreiosResponse
  attr_accessor :correiosResult

  def initialize(correiosResult = nil)
    @correiosResult = correiosResult
  end
end

# {http://tempuri.org/}CorreiosXml
#   cepOrigem - SOAP::SOAPString
#   cepDestino - SOAP::SOAPString
#   peso - SOAP::SOAPString
#   volume - SOAP::SOAPString
#   codigo - SOAP::SOAPString
class CorreiosXml
  attr_accessor :cepOrigem
  attr_accessor :cepDestino
  attr_accessor :peso
  attr_accessor :volume
  attr_accessor :codigo

  def initialize(cepOrigem = nil, cepDestino = nil, peso = nil, volume = nil, codigo = nil)
    @cepOrigem = cepOrigem
    @cepDestino = cepDestino
    @peso = peso
    @volume = volume
    @codigo = codigo
  end
end

# {http://tempuri.org/}CorreiosXmlResponse
#   correiosXmlResult - SOAP::SOAPString
class CorreiosXmlResponse
  attr_accessor :correiosXmlResult

  def initialize(correiosXmlResult = nil)
    @correiosXmlResult = correiosXmlResult
  end
end
