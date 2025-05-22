*** Keywords ***
Open Browser To Tripadvisor
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Wait Until Page Contains Element    css:.attraction_element

Go To Swakopmund Attractions Page
    Go To    ${URL}
    Wait Until Page Contains    Things to Do in Swakopmund

Scrape All Tripadvisor Attractions
    ${cards}=    Get WebElements    xpath=//div[@class='alPVI eNNhq PgLKC tnGGX']
    ${attractions}=    Create List

    FOR    ${card}    IN    @{cards}
        ${name}=    Get Text    xpath=./div/div/a
        ${rating_element}=    Get WebElement    xpath=.//svg[contains(@aria-label, 'bubbles')]
        ${rating}=    Get Element Attribute    ${rating_element}    aria-label
        ${clean_rating}=    Evaluate    re.search(r'(\d\.\d)', '''${rating}''').group(1)    re
        ${review_text}=    Get Text    xpath=.//span[contains(text(),'review')]
        ${reviews}=    Evaluate    re.search(r'(\d+(,\d+)*)', '''${review_text}''').group(1)    re
        Append To List    ${attractions}    {"name": "${name}", "rating": "${clean_rating}", "reviews": "${reviews}"}
    END

    Set Suite Variable    ${attractions}

Save Data To JSON
    [Arguments]    ${path}
    ${json}=    Evaluate    json.dumps(${attractions}, indent=2)    json
    Create File    ${path}    ${json}
