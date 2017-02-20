# mediation-dep-gw
WSO2 ESB Mediation logic for Gateway Release

## Setting up the Deployment
The deployment consists of configuring 2 products:
1. wso2esb
2. wso2telcohub

## Configuring WSO2 ESB
Download a fresh __WSO2 ESB 5.0.0__ pack from website: http://wso2.com/products/enterprise-service-bus/
Add follwoing .jar files to ESB as described:

* To *ESB_HOME/repository/components/dropins* 
```
 dbutils-2.0.4-SNAPSHOT.jar (repository: WSO2Telco/core-utils)
 javax.persistence_1.0.0.jar (external)
 json_3.0.0.wso2v1.jar (external)
 msisdn-validator-2.0.4-SNAPSHOT.jar 
 operator-service-3.0.0-SNAPSHOT.jar (repository: WSO2Telco/component-dep)
 subscription-validator-3.0.0-SNAPSHOT.jar
 ```

* To *ESB_HOME/repository/components/lib*
```
 com.wso2telco.dep.spend.limit.mediator-1.0.0-SNAPSHOT.jar (repository: WSO2Telco/mediation-dep)
 mediator-1.0.0-SNAPSHOT.jar (repository: WSO2Telco/mediation-dep/mediation-old)
 mnc-resolver-2.0.4-SNAPSHOT.jar (repository: WSO2Telco/component-dep)
 oneapi-validation-2.1.0-SNAPSHOT.jar (repository: WSO2Telco/component-dep)
 mysql-connector-java-5.1.36-bin.jar (external)
 ```

Add following configuration files:
* *mediator-conf.properties* to *ESB_HOME/repository/conf* 
(repository: https://github.com/WSO2Telco/component-dep/blob/master/features/com.wso2telco.dep.hub.core.feature/src/main/resources/config/mediator-conf.properties)

* *MobileCountryConfig.xml* to *ESB_HOME/repository/conf* 
(repository: https://github.com/WSO2Telco/component-dep/features/com.wso2telco.dep.hub.core.feature/src/main/resources/config/MobileCountryConfig.xml)

* *spendLimit.xml* to *ESB_HOME/repository/conf* 
(repository:https://github.com/WSO2Telco/component-dep/blob/master/features/com.wso2telco.dep.hub.core.feature/src/main/resources/config/spendLimit.xml)

Configuring datasources

* Add following database references:
__proddepdb__ and __prodUMdb__ (with suitable user credentials) at *ESB_HOME/repository/conf/datasources/masterdatasources.xml*
proddepdb : http://docs.wso2telco.com/display/HG/Setup+DEP+database
prodUMdb : http://docs.wso2telco.com/display/HG/Setup+++User+Manager+database

*Important: Same databases has to refer while settingup __wso2telcohub__*

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
4. Create APIs for nececssary use-cases and configure endpoint to ESB APIs. API __context__ should be as follows:
* payment
* ussd
* location
* smsmessaging
5. Add __validator-handler.jar__ at repository: component-dep/components/validator-handler/target to wso2telcohub/repository/components/lib
6. Add Sequence __httpHeaderSeq.xml__ at component-dep/blob/master/components/mediator/src/main/resources/httpHeaderSeq.xml to wso2telcohub/repository/deployment/server/synapse-configs/default/sequences
7. Add following sequence to inSequence :
```
<sequence key="httpHeaderSeq"/>
```
(source: https://github.com/WSO2Telco/component-dep/blob/master/components/mediator/src/main/resources/httpHeaderSeq.xml)
8. Add following handler to each API:
```
<handler class="com.wso2telco.dep.validator.handler.APIInfoHandler"/>
```
(source: https://github.com/WSO2Telco/component-dep/blob/master/components/validator-handler/src/main/java/com/wso2telco/dep/validator/handler/APIInfoHandler.java)

