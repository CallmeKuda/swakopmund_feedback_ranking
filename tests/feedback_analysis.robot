*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           OperatingSystem
Library           BuiltIn
Library           Process
Suite Setup       Open Browser To NTS Reviews
Suite Teardown    Close Browser

*** Variables ***
${URL}            https://www.namibia-tours-safaris.com/about-us/traveller-reviews
${OUTPUT_JSON}    output/nts_reviews.json

*** Test Cases ***
Scrape NTS Traveller Reviews
    [Documentation]    Scrape traveler reviews from Namibia Tours & Safaris website
    Go To NTS Reviews Page
    Scrape All NTS Reviews
    Save Data To JSON    ${OUTPUT_JSON}
    Generate Review Graph
    Capture Page Screenshot

*** Keywords ***
Open Browser To NTS Reviews
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Wait Until Page Contains Element    css=.reviews-div

Go To NTS Reviews Page
    Go To    ${URL}
    Wait Until Page Contains    Traveller Reviews

Scrape All NTS Reviews
    ${reviews}=    Create List
    ${elements}=    Get WebElements    css=.reviews-div
    FOR    ${element}    IN    @{elements}
        ${name}=    Get Text    xpath=.//h3
        ${comment}=    Get Text    xpath=.//p
        ${review}=    Create Dictionary    name=${name}    comment=${comment}
        Append To List    ${reviews}    ${review}
    END
    Set Suite Variable    ${reviews}

Save Data To JSON
    [Arguments]    ${path}
    ${json}=    Evaluate    json.dumps(${reviews}, indent=2)    json
    Create File    ${path}    ${json}

Generate Review Graph
    [Documentation]    Run Python script to generate review graph
    ${result}=    Run Process    python    scripts/plot_reviews.py
    Should Be Equal As Integers    ${result.rc}    0    msg=Graph generation failed
