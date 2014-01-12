#!/usr/bin/ruby

 require "azure"

 #Recuerda establecer las variables de entorno AZURE_STORAGE_ACCOUNT and AZURE_STORAGE_ACCESS_KEY

azure_blob_service = Azure::BlobService.new
containers = azure_blob_service.list_containers()

puts "\nEJERCICIO 10 JAIME TORRES BENAVENTE"

