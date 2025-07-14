*** Settings ***
Library    SSHLibrary

*** Test Cases ***
Check if dokploy is installed correctly
    ${dokploy}  ${rc} =    Execute Command    add-module ${IMAGE_URL} 1
    ...    return_rc=True
    Should Be Equal As Integers    ${rc}  0
    &{dokploy} =    Evaluate    ${dokploy}
    Set Suite Variable    ${module_id}    ${dokploy.module_id}

Check if dokploy can be configured
    ${rc} =    Execute Command    api-cli run module/${module_id}/configure-module --data '{}'
    ...    return_rc=True  return_stdout=False
    Should Be Equal As Integers    ${rc}  0

Check if dokploy works as expected
    ${rc} =    Execute Command    curl -f http://127.0.0.1/dokploy/
    ...    return_rc=True  return_stdout=False
    Should Be Equal As Integers    ${rc}  0

Check if dokploy is removed correctly
    ${rc} =    Execute Command    remove-module --no-preserve ${module_id}
    ...    return_rc=True  return_stdout=False
    Should Be Equal As Integers    ${rc}  0
