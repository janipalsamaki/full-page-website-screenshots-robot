*** Settings ***
Documentation     Takes full page screenshots of given websites.
Library           Browser
Library           RPA.Tables
Task Setup        Register Keyword To Run On Failure    ${NONE}

*** Variables ***
${WEBSITES_CSV}=    websites.csv

*** Keywords ***
Take full page screenshot
    [Arguments]    ${url}    ${accept_cookies_selector}
    New Page    ${url}
    Run Keyword And Ignore Error    Click    ${accept_cookies_selector}
    ${domain}=    Evaluate    urllib.parse.urlparse('${url}').netloc
    Run Keyword And Ignore Error
    ...    Take Screenshot
    ...    ${CURDIR}${/}output${/}${domain}
    ...    fullPage=True

*** Tasks ***
Take full page screenshots of given websites
    @{websites}=    Read Table From Csv    ${WEBSITES_CSV}    header=True
    FOR    ${website}    IN    @{websites}
        Take full page screenshot
        ...    ${website}[url]
        ...    ${website}[accept_cookies_selector]
    END
