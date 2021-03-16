# arm-template-hacks

## Execute JavaScript in an ARM Template
* Deploy [setup.bicep](javascript/setup.bicep) one time to setup the execution environment. Use the output of this template as the input for the deploy script.
* See [deploy.bicep](javascript/deploy.bicep) for an example of invoking arbitrary Javascript and getting the result in a template.
