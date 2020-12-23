param providerName string

resource testResource 'Microsoft.CustomProviders/resourceProviders/testResource@2018-09-01-preview' = {
  name: '${providerName}/abc'
  properties: {
    test: 2
  }
}

output testOut object = testResource