param kubeconfig string
param manifest string

resource deployScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'deployScript'
  location: resourceGroup().location
  kind: 'AzureCLI'
  properties: {
    azCliVersion: '2.9.1'
    retentionInterval: 'PT4H'
    environmentVariables: [
      {
        name: 'DS_KUBECONFIG'
        secureValue: base64(kubeconfig)
      }
      {
        name: 'DS_MANIFEST'
        secureValue: base64(manifest)
      }
    ]
    scriptContent: '''
#!/bin/bash

mkdir -p ~/.kube
echo $DS_KUBECONFIG | base64 -d > ~/.kube/config
echo $DS_MANIFEST | base64 -d > manifest.yml

az aks install-cli
kubectl apply -f manifest.yml

external_ip=''
while [ -z $external_ip ]; do
  external_ip=$(kubectl get service azure-vote-front --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
  [ -z "$external_ip" ] && sleep 5
done

echo '{"external_ip": "'$external_ip'"}' > $AZ_SCRIPTS_OUTPUT_PATH
'''
  }
}

output externalIp string = deployScript.properties.outputs['external_ip']
