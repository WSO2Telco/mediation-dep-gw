================================================================================
                         APIGATE AXP EXTERNAL GATEWAY Mediation 3.0.0
================================================================================

Configuring WSO2 EI

1. Download and extract a fresh WSO2 EI 6.1.1 pack from website: https://wso2.com/integration/previous-releases/
2. Copy files as follows:
    conf -> {EI_HOME}/conf
    dropins -> {EI_HOME}/dropins
    lib -> {EI_HOME}/lib
    repository/deployment/server/carbonapps -> {EI_HOME}/repository/deployment/server/carbonapps

   Alternatively you can execute the following command (from extracted mediation pack) to copy all files at once

    `cp -r * {EI_HOME}`

3. Download the following external libraries to the following locations:

    {EI_HOME}/dropins
        * javax.persistence_1.0.0.jar - http://www.java2s.com/Code/Jar/j/Downloadjavaxpersistence100jar.htm
        * json_3.0.0.wso2v1.jar - http://maven.wso2.org/nexus/content/repositories/wso2-public/org/json/wso2/json/3.0.0.wso2v1/json-3.0.0.wso2v1.jar

     {EI_HOME}/lib
        * mysql-connector-java-5.1.40-bin.jar - http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.40/mysql-connector-java-5.1.40.jar

4. Add the following database configurations to the `{EI_HOME}/conf/datasources/master-datasources.xml` file for the following databases:
    * WSO2TELCO_DEP_DB
    * WSO2UM_DB
    * WSO2AM_STATS_DB

5. Update the following configuration files to suite your deployment:
    * mediator-conf.properties
    * MobileCountryConfig.xml
    * oneapi-validation-conf.properties

6. Start the Enterprise Integrator with the following command:
    Windows: ./integrator.bat
    Unix: ./integrator.sh
