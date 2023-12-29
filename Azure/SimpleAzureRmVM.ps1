Param(
# Variables for common values
[string]$resourceGroup = "RWResGrp1",
[string]$storageAcctName ="rwstor1", # lowercase oonly
[string]$location = "Canada Central",
[string]$vnetName="RW-Vnet1",
[string]$NicName="NIC1",
[string]$diskname="Disk1",
[string]$vmName = "RWLinux1"
)
         

#Check for open session
Connect-AzAccount

# Create user object
$cred = Get-Credential -Message "Enter username and password of administrator crendentials"

# Create a resource group
New-AzResourceGroup -Name $resourceGroup -Location $location

#Create a storage account
New-AzStorageAccount -Name $storageAcctName -ResourceGroupName $resourceGroup -Type Standard_LRS -Location $location                                                                                    


# Create a subnet configuration
$subnetCfg = New-AzVirtualNetworkSubnetConfig -Name mySubnet -AddressPrefix 10.0.1.0/24

# Create a virtual network
$vnet=New-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup -Location $location -AddressPrefix 10.0.0.0/16 -Subnet $subnetCfg

#Create First NSG Rule
$rule1 = New-AzNetworkSecurityRuleConfig -Name SSH-Rule -Description "Allow SSH" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22  

# Create NSG
$nsg = New-AzNetworkSecurityGroup -Name $nsgName-ResourceGroupName $resourceGroup -Location $location -SecurityRules $rule1 

# Create a public IP address and specify a DNS name


# Create a virtual network card and associate with public IP address and NSG
$nic=New-AzNetworkInterface -Name $vmName$nicname -ResourceGroupName $resourceGroup -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $IP.Id -NetworkSecurityGroup $nsg                                        



#Create a blob storage
$storageAccount=Get-AzStorageAccount -ResourceGroupName $resourceGroup -Name $storageAcctName                
$osdiskuri=$storageAccount.PrimaryEndpoints.Blob.ToString()+'vhds/'+$diskname+".vhd" 

# Create a virtual machine configuration
$vm =New-AzVMConfig -VMName $vmname -VMSize "Basic_A1"
$vm=Set-AzVMOperatingSystem -VM $vm -Linux -ComputerName $vmname -Credential $cred
$vm=Set-AzVMSourceImage -VM $vm -PublisherName 'Canonical' -Offer 'UbuntuServer' -Skus '18.04-LTS' -Version 'latest'
$vm=Add-AzVMNetworkInterface -VM $vm -id $nic.Id
$vm=Set-AzVMOSDisk -VM $vm -Name $vmName$diskname -VhdUri $osdiskuri -CreateOption fromImage 

       

# Create a virtual machine
New-AzVM -ResourceGroupName $resourceGroup -Location $location -VM $vm  