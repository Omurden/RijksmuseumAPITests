*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${API_KEY}        0fiuZFh4
${BASE_URL}       https://www.rijksmuseum.nl/api/en/collection
${OBJECT_ID}      SK-C-5 

*** Test Cases ***
Retrieve Collections
    [Documentation]    Test to retrieve collections from Rijksmuseum API
    Create Session    Rijksmuseum    ${BASE_URL}
    ${response}=      GET On Session    Rijksmuseum    url=?key=${API_KEY}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}
    ${art_objects}=    Get From Dictionary    ${response.json()}    artObjects
    Should Not Be Empty    ${art_objects}

