*** Settings ***
Resource               ../resources/common.resource
Suite Setup            OpenBrowser                 about:blank    chrome
Suite Teardown         CloseAllBrowsers

*** Test Cases ***
Sample
    [Documentation]
    [Tags]

    ${msg}=            Get Last Mailsac Email
    Log                Latest email content: ${msg}  console=True


