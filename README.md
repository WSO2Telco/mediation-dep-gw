# mediation-dep-gw
WSO2 ESB Mediation Logic for Gateway Release

## Setting up the Deployment
The deployment consists of configuring 2 products:

1. wso2esb
2. wso2telcohub

## Configuring WSO2 ESB
Download a fresh __WSO2 ESB 5.0.0__ pack from website: http://wso2.com/products/enterprise-service-bus/

Add following .jar files to ESB as described (WSO2.Telco related files are bundled with *wso2telco_esb_externals.zip*):

* To *ESB_HOME/repository/components/dropins* 
```
 dbutils.jar (repository: WSO2Telco/core-util)
 mnc-resolver.jar (repository: WSO2Telco/core-util)
 msisdn-validator.jar (repository: WSO2Telco/core-util)
 operator-service.jar (repository: WSO2Telco/component-dep)
 subscription-validator.jar (repository: WSO2Telco/component-dep)
 javax.persistence_1.0.0.jar (external: http://www.java2s.com/Code/Jar/j/Downloadjavaxpersistence100jar.htm)
 json_3.0.0.wso2v1.jar (external: http://maven.wso2.org/nexus/content/repositories/wso2-public/org/json/wso2/json/3.0.0.wso2v1/json-3.0.0.wso2v1.jar)
 ```

* To *ESB_HOME/repository/components/lib*
```
 oneapi-validation.jar (repository: WSO2Telco/component-dep)
 com.wso2telco.dep.spend.limit.mediator.jar (repository: WSO2Telco/mediation-dep)
 mediator.jar (repository: WSO2Telco/mediation-dep/mediation-old)
 mysql-connector-java-5.1.36-bin.jar (external: http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.36/mysql-connector-java-5.1.36.jar)
 ```

Add following configuration files:
* *mediator-conf.properties* to *ESB_HOME/repository/conf* 
(repository: https://github.com/WSO2Telco/component-dep/blob/master/features/com.wso2telco.dep.hub.core.feature/src/main/resources/config/mediator-conf.properties)

* *MobileCountryConfig.xml* to *ESB_HOME/repository/conf* 
(repository: https://github.com/WSO2Telco/component-dep/blob/master/features/com.wso2telco.dep.hub.core.feature/src/main/resources/config/MobileCountryConfig.xml)

* *spendLimit.xml* to *ESB_HOME/repository/conf* 
(repository:https://github.com/WSO2Telco/component-dep/blob/master/features/com.wso2telco.dep.hub.core.feature/src/main/resources/config/spendLimit.xml)

Configuring datasources

* Add following database references:
__proddepdb__ and __prodUMdb__ (with suitable user credentials) at *ESB_HOME/repository/conf/datasources/masterdatasources.xml*

proddepdb : http://docs.wso2telco.com/display/HG/Setup+DEP+database

prodUMdb : http://docs.wso2telco.com/display/HG/Setup+++User+Manager+database

*Important: Same databases are referred while setting up __wso2telcohub__*

Clone this repository and build using maven ($ mvn clean install)

There will be 5 CApp files (.car files) created in following locations
```
* mediation-dep-gw/com.wso2telco.dep.gw.common/commongw_capp/target/commongw_capp.car
* mediation-dep-gw/com.wso2telco.dep.gw.locationapi/locationapigw_capp/target/locationapigw_capp.car
* mediation-dep-gw/com.wso2telco.dep.gw.paymentapi/paymentapigw_capp/target/paymentapigw_capp.car
* mediation-dep-gw/com.wso2telco.dep.gw.smsapi/smsapigw_capp/target/smsapigw_capp.car
* mediation-dep-gw/com.wso2telco.dep.gw.ussdapi/ussdapigw_capp/target/ussdapigw_capp.car
```

Start WSO2 ESB and upload CApp files (Refer: https://docs.wso2.com/display/ESB481/Creating+and+Deploying+a+Carbon+Application)


## Configuring WSO2 TELCO HUB
1. Download WSO2 TELCO HUB (for Gateway) from website: http://wso2telco.com/hub
2. Configure databases and workflow. (If database has already created, you only need to add relevant configurations).

Database configurations: http://docs.wso2telco.com/pages/viewpage.action?pageId=1507746

Workflow configurations: http://docs.wso2telco.com/display/HG/Install+workflows

3. Start WSO2 TELCO HUB and goto Publisher app 

4. Create APIs for necessary use-cases and configure endpoint to ESB APIs. API __context__ should be as follows:

* payment
* ussd
* location
* smsmessaging

If WSO2 Telco Hub is port offset, change the port numbers at the following files accordingly

* TELCO_HUB_HOME/repository/deployment/server/jaggeryapps/manage/site/conf/site.json
* TELCO_HUB_HOME/repository/conf/workflow.properties
* TELCO_HUB_HOME/repository/resources/workflow-extensions.xml

