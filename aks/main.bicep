targetScope = 'subscription'

@description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string

@description('User name for the Linux Virtual Machines.')
param linuxAdminUsername string

@description('Configure all linux machines with the SSH RSA public key string. Your key should include three parts, for example \'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm\'')
param sshRSAPublicKey string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'aks_test'
  location: deployment().location
}

module aks './modules/aks.bicep' = {
  name: 'aks-deploy'
  scope: rg
  params: {
    sshRSAPublicKey: sshRSAPublicKey
    linuxAdminUsername: linuxAdminUsername
    dnsPrefix: dnsPrefix
  }
}

module kubernetes './modules/kubernetes.bicep' = {
  name: 'kubernetes-deploy'
  scope: rg
  params: {
    kubeconfig: aks.outputs.kubeconfig
    manifest: loadTextContent('./assets/manifest.yml')
  }
}

output webUrl string = 'http://${kubernetes.outputs.externalIp}/'
