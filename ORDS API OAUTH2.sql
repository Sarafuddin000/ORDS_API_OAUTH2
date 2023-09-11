--Fist thing first

--1. Create Role for API User
        SQL Workshop    >   RESTful Services\Roles\Role Definition

--2. Create Privileges for API User
        SQL Workshop    >   RESTful Services\Privileges\Privilege Definition

--3. Now Create API Module 
        SQL Workshop    >   RESTful Services\Modules

--4. You can check your created API link from anywhere / any browser, its public

--5. To prevent public access you need to create client to access API

        begin
            oauth.create_client(
                p_name => 'api_user',
                p_grant_type => 'client_credentials',
                p_description => 'For accessing API',
                p_support_email => 'qmsarafuddin0@gmail.com',
                p_privilege_names => 'api_access_prv');
        commit;
        end;

--6. Now you need to grant already created role for this client  
   
        begin
            oauth.grant_client_role(
                p_client_name => 'api_user',
                p_role_name => 'api_access_role');
        commit;
        end;

--7. Now check your CLEINT_ID and CLEINT_SECRET for newly created client

        select * from user_ords_clients;

--8. Now you can check your API using POSTMAN, IF its Response 200 (OK) then your API is publicly accessible.
--To prevent public access you need to go back         
SQL Workshop    >   RESTful Services\Privileges\
--and then go to your created Privilege and Protect your module.

--9. Now Check again and you will get Response 401 (Unauthorized).

--10. To access with OAuth2.0 you follow this steps below:
    a.  Go to Authorization tab
    b.  Set Type OAuth 2.0
    c.  Configure New Token
    d.  Token Name 'As you want'
    e.  Grant Type 'Client Credentials'
    f.  Access Token URL 'https://apex.oracle.com/pls/apex/{WORKSPACE_NAME}/oauth/token'
    g.  Client ID   'That you found from step 7'
    h.  Client Secret   'That you found from step 7'
    i.  Client Authentication   'Send as Basic Auth Header'
    j.  Now press Get New Access Token and Use Token

--11. Now hit the API Link again and you will get 
        Status 200 (OK)

--12. If you want to access the token with Basic auth then you need to pass the username and password to access the API.

    select apex_web_service.make_rest_request(p_url => 'https://apex.oracle.com/pls/apex/jasmr/EMP/ALL',
        p_http_method => 'GET',
        p_username => 'qmsarafuddin0@gmail.com',
        p_password => 'Suddin000') from dual;


--13. Enjoy and spread!


****For detail guideline: https://oracle-base.com/articles/misc/oracle-rest-data-services-ords-authentication
        Auth token refresh time setup: from https://auth0.com/docs/secure/tokens/refresh-tokens/configure-refresh-token-expiration
        Auth Token refresh time setup using ORDS: https://www.jmjcloud.com/blog/ords-changing-the-default-oauth2-token-expiry-lifetime
