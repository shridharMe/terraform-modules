#!/bin/bash
set -e
while getopts "m:s:" opt; do
   case $opt in  
    m) module="$OPTARG"    
      ;;
    s) runcmd="$OPTARG"
      ;;
    \?) echo "Invalid option -$OPTARG" >&2
       ;;
  esac
done

  
if  [ -z ${module} ] || [ -z ${runcmd} ]     ; then
    printf "\n"
    printf "Please provide terraform module name and testing step\n\n"
    printf "./provision.sh  -m vpc \n"  
    printf "\n"
else 
    kitchen_file_path=./testing/${module}/    
    cd $kitchen_file_path   
    if [ ${runcmd} == "create" ];then
      export TF_WARN_OUTPUT_ERRORS=1
      # Destroy any existing Terraform state 
      /usr/local/rvm/gems/ruby-2.4.4/wrappers/bundle exec kitchen destroy aws

      # Initialize the Terraform working directory and select a new Terraform workspace        
      /usr/local/rvm/gems/ruby-2.4.4/wrappers/bundle exec kitchen create aws
    
    elif [ ${runcmd} == "converge" ];then 
      # Apply the Terraform root module to the Terraform state using the Terraform        
      /usr/local/rvm/gems/ruby-2.4.4/wrappers/bundle exec kitchen converge aws

    elif [ ${runcmd} == "verify" ];then 
      # Test the Terraform state using the InSpec controls
      /usr/local/rvm/gems/ruby-2.4.4/wrappers/bundle exec kitchen verify aws

    elif [ ${runcmd} == "destroy" ];then 
      # Destroy the Terraform state using the Terraform fixture configuration
      /usr/local/rvm/gems/ruby-2.4.4/wrappers/bundle exec kitchen destroy aws     
      unset TF_WARN_OUTPUT_ERRORS         

    fi
    
 
       
fi