iPadShell
==============

Inspired by dotfiles but built to run in Kubernetes. This will create a pod running on Kubernetes that provides a full Ubuntu dev environment, including IBM Cloud tools, Kubernetes, and many other things. 

Accessible via SSH and MOSH using an IKS LoadBalancer. 

- SSH on port 3222
- MOSH on port 31721 

Architecture
--------------

- The git repo contains the core .files like zshrc. You can update the repo and restart the container and the files will update without having to rebuild the Docker image.

- The Docker image contains the core tools and should be rebuild and redeployed to add new permanent tools to the environment

- The pod mounts a PVC in using S3FS that holds the cluster config files for IKS from your local machine. This allows the config to persist across pod deployments and prevents these files from having to be loaded into Github or the image, exposing keys. The PVC can also be used to hold files you want to edit and persists permenantly. The updateClusterConfigs.sh script will upload your IKS config files to the PVC in a running instance of the pod over SSH.

- The only key stored in the image or Github is your public SSH key. 

