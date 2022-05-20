# azure_network_terraform
Root and child module for deploying a cloud network infrastructure in Azure

The "network.tf" or the root file is dependent on 8 child modules.

The whole dependcies can be used deploy a network architecture in azure, any additional dependencies or functions can be directly added in the child modules.

To keep it simple root module takes care of the repatative tasks, thereby controlling child modules variables or dependencies. All the variables can be assigned directly in the root module itself.
