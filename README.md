# k8s

# Login to Azure
    az login
    az account set --subscription=<subscriptionId>
    az account show

# Show existing resources
    az resource list

# Create RG, ACR and AKS
    ./infra/azcli/script.sh

# Variables
    RESOURCE_GROUP="rg-onlinestore-dev-uksouth-001"
    AKS_NAME="aks-onlinestore-dev-uksouth-001"
    ACR_NAME="acronlinestoredevuksouth001"

# connect to cluster
    az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_NAME

# Short name for kubectl
    alias k=kubectl

# Show all existing objects
    k get all

# Log in to ACR
    az acr login --name $ACR_NAME
    
# You may want to use 'az acr login -n acronlinestoredevuksouth001 --expose-token' to get a refresh token, which does not require Docker to be installed.

# Tag and push the Docker images

    # Order Service
    docker build -t order ./app/order-service 
    docker tag order $ACR_NAME.azurecr.io/order:v1
    docker push $ACR_NAME.azurecr.io/order:v1

    # Product Service
    docker build -t product ./app/product-service 
    docker tag product $ACR_NAME.azurecr.io/product:v1
    docker push $ACR_NAME.azurecr.io/product:v1

    # Store Front Service
    docker build -t store-front ./app/store-front
    docker tag store-front $ACR_NAME.azurecr.io/store-front:v1
    docker push $ACR_NAME.azurecr.io/store-front:v1

# Deploy all the services using manifest files
    k apply -f ./manifests

# Delete all the services using manifest files  
    k delete -f ./manifests

# Deploy all the services using helm chart
    helm install storeapp ./helmchart
# Upgrade using helm chart
    helm upgrade storeapp ./helmchart
# Delete Services using helm
    helm uninstall storeapp

# Clean the Azure resources
    az group delete --name rg-onlinestore-dev-uksouth-001 --yes --no-wait



# helmify  
helmify -f /manifests/ helmchart