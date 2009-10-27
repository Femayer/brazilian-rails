require 'soap/mapping'

module DefaultMappingRegistry
  EncodedRegistry = ::SOAP::Mapping::EncodedRegistry.new
  LiteralRegistry = ::SOAP::Mapping::LiteralRegistry.new
  NsTempuriOrg = "http://tempuri.org/"

  LiteralRegistry.register(
    :class => Correios,
    :schema_name => XSD::QName.new(NsTempuriOrg, "Correios"),
    :schema_element => [
      ["cepOrigem", "SOAP::SOAPString", [0, 1]],
      ["cepDestino", "SOAP::SOAPString", [0, 1]],
      ["peso", "SOAP::SOAPString", [0, 1]],
      ["volume", "SOAP::SOAPString", [0, 1]],
      ["codigo", "SOAP::SOAPString", [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => CorreiosResponse,
    :schema_name => XSD::QName.new(NsTempuriOrg, "CorreiosResponse"),
    :schema_element => [
      ["correiosResult", ["SOAP::SOAPString", XSD::QName.new(NsTempuriOrg, "CorreiosResult")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => CorreiosXml,
    :schema_name => XSD::QName.new(NsTempuriOrg, "CorreiosXml"),
    :schema_element => [
      ["cepOrigem", "SOAP::SOAPString", [0, 1]],
      ["cepDestino", "SOAP::SOAPString", [0, 1]],
      ["peso", "SOAP::SOAPString", [0, 1]],
      ["volume", "SOAP::SOAPString", [0, 1]],
      ["codigo", "SOAP::SOAPString", [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => CorreiosXmlResponse,
    :schema_name => XSD::QName.new(NsTempuriOrg, "CorreiosXmlResponse"),
    :schema_element => [
      ["correiosXmlResult", ["SOAP::SOAPString", XSD::QName.new(NsTempuriOrg, "CorreiosXmlResult")], [0, 1]]
    ]
  )
end
