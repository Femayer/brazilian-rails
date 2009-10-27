PROJECTS = %w(brnumeros brdinheiro brcep brdata brhelper brstring brcpfcnpj brfrete)

PROJECTS.each do |project|
  require "#{File.dirname(__FILE__)}/#{project}/rails/init"
end
