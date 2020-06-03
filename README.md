# Blue/Green Kubernetes deployment with spring-boot

In this example will be shown how todo a blue/green deployment in kubernetes for a simple spring-boot application.

Minikube will be used in localhost for testing. This example has been done on a windows 10 machine with minikube and docker runtime.

## Deploy first version

First of all lets start minikube

    minikube start --container-runtime=docker

In case minikube still not set up to use docker Runtime:

    minikube docker-env

    minikube -p minikube docker-env | Invoke-Expression

Now create the application package

    ./mvnw package

Next build the docker image

    docker build -t spring-boot-ab-deployment:0.0.1 .

In case you want to run the image just on docker

    docker run --name spring-boot-ab-deployment  -p 86:8080 spring-boot-ab-deployment

Namespace "sandbox" will be used, so if does not existes lets create it

    kubectl create namespace sandbox

Then apply the deployment

    kubectl apply -f .\deployment.yaml
    
After some time the pod will be running

    kubectl get pods -n sandbox
    kubectl describe pods spring-boot-ab-deployment -n sandbox
To open the endpoint exposed to see what the application does (just a simple text response)

    minikube service spring-boot-ab-deployment --url -n sandbox
    
You should get a URL like this
* http://192.168.239.234:31660
Opening it in the browser will show you the application response

## Deploy second version

First of all lets do some changes in our code, for example changing the response returned by the Controller and package the second version. Changing the version in pom.xml is also recommended

    ./mvnw package


Then lets build another image for the second version

    docker build -t spring-boot-ab-deployment:0.0.2 .

And lets apply the deployment for the second version

    kubectl apply -f .\deployment-v2.yaml

Afterwards running the following command we can see the two versions running at the same time

    kubectl get pods -n sandbox

Now lets get the second version endpoint to see what it does

    minikube service spring-boot-ab-deployment-v2 --url -n sandbox

Now we have verified second version is running as well.

To delete the pods

    kubectl delete deployment spring-boot-ab-deployment -n sandbox
    kubectl delete deployment spring-boot-ab-deployment-v2 -n sandbox
  

What could be done now in some staging environment is to redirect some traffic to the second version to fully test it.