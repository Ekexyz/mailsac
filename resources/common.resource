*** Settings ***
Library                         RequestsLibrary
Library                         QForce
Library                         String
Library                         Collections

*** Variables ***
${mailsac_key}                  k_..................................
${mailsac_email}                ........................@mailsac.com

*** Keywords ***
Get Last Mailsac Email
    [Documentation]             Return the latest email content from Mailsac inbox

    # Set headers
    ${headers}=                 Create Dictionary
    Set To Dictionary           ${headers}                  Mailsac-Key                 ${mailsac_key}
    Set To Dictionary           ${headers}                  Accept                      application/json

    # Send a GET request
    # https://mailsac.com/docs/api#tag/Messages/operation/ListMessages
    ${response}=                GET                         url=https://mailsac.com/api/addresses/${mailsac_email}/messages?limit=1
    ...                         headers=${headers}
    Should Be Equal As Strings                              ${response.status_code}     200

    # Get latest Email Id
    ${email}=                   Get From List               ${response.json()}          0
    ${id}=                      Get From Dictionary         ${email}                    _id

    # Get plain text content of Email by Id
    # https://mailsac.com/docs/api#tag/Messages/operation/GetBodyPlainText
    ${response}=                GET                         url=https://mailsac.com/api/text/${mailsac_email}/${id}
    ...                         headers=${headers}
    Should Be Equal As Strings                              ${response.status_code}     200
    [Return]                    ${response.text}

