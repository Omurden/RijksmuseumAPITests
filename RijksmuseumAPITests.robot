*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${API_KEY}        ${ENV:API_KEY}
${BASE_URL}       https://www.rijksmuseum.nl/api
${LANGUAGE}       en
${OBJECT_ID}      SK-C-5
${INVALID_OBJECT_ID}  123456789

*** Test Cases ***
Retrieve Collections
    [Documentation]    Test to retrieve collections from Rijksmuseum API
    Create Session    Rijksmuseum    ${BASE_URL}
    ${params}=        Create Dictionary    key=${API_KEY}    q=Rembrandt
    ${response}=      GET On Session    Rijksmuseum    url=/${LANGUAGE}/collection    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}
    ${art_objects}=    Get From Dictionary    ${response.json()}    artObjects
    Should Not Be Empty    ${art_objects}

Retrieve Object Details
    [Documentation]    Test to retrieve details of a specific art object
    Create Session    Rijksmuseum    ${BASE_URL}
    ${params}=        Create Dictionary    key=${API_KEY}
    ${response}=      GET On Session    Rijksmuseum    url=/${LANGUAGE}/collection/${OBJECT_ID}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}
    ${art_object}=    Get From Dictionary    ${response.json()}    artObject
    Dictionary Should Contain Key    ${art_object}    title
    Dictionary Should Contain Key    ${art_object}    objectNumber
    ${object_number}=    Get From Dictionary    ${art_object}    objectNumber
    Should Be Equal    ${object_number}    ${OBJECT_ID}

Retrieve Object Details in Dutch
    [Documentation]    Test to retrieve details of a specific art object in Dutch
    ${LANGUAGE}=       Set Variable    nl
    Create Session    Rijksmuseum    ${BASE_URL}
    ${params}=        Create Dictionary    key=${API_KEY}
    ${response}=      GET On Session    Rijksmuseum    url=/${LANGUAGE}/collection/${OBJECT_ID}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}
    ${art_object}=    Get From Dictionary    ${response.json()}    artObject
    Dictionary Should Contain Key    ${art_object}    title
    Dictionary Should Contain Key    ${art_object}    objectNumber
    ${object_number}=    Get From Dictionary    ${art_object}    objectNumber
    Should Be Equal    ${object_number}    ${OBJECT_ID}
    ${title}=    Get From Dictionary    ${art_object}    title
    Log    Title in Dutch: ${title}
    Should Contain    ${title}    Nachtwacht     # Dutch check for the title

Retrieve Invalid Object Details
    [Documentation]    Test to retrieve details of an invalid art object
    Create Session    Rijksmuseum    ${BASE_URL}
    ${params}=        Create Dictionary    key=${API_KEY}
    ${response}=      GET On Session    Rijksmuseum    url=/${LANGUAGE}/collection/${INVALID_OBJECT_ID}    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}
    ${art_object}=    Get From Dictionary    ${response.json()}    artObject
    Should Be Equal    ${art_object}     ${None}

Retrieve Collections Without Query
    [Documentation]    Test to retrieve collections without a query parameter
    Create Session    Rijksmuseum    ${BASE_URL}
    ${params}=        Create Dictionary    key=${API_KEY}
    ${response}=      GET On Session    Rijksmuseum    url=/${LANGUAGE}/collection    params=${params}
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.json()}
    ${art_objects}=    Get From Dictionary    ${response.json()}    artObjects
    Should Not Be Empty    ${art_objects}

Retrieve Collections With Invalid API Key
    [Documentation]    Test to retrieve collections with an invalid API key
    Create Session    Rijksmuseum    ${BASE_URL}
    ${params}=        Create Dictionary    key=INVALID_KEY    q=Rembrandt
    ${response}=      GET On Session    Rijksmuseum    url=/${LANGUAGE}/collection    params=${params}  expected_status=401
    Should Be Equal As Numbers    ${response.status_code}    401

Retrieve Object Details Without API Key
    [Documentation]    Test to retrieve details of an object without an API key
    Create Session    Rijksmuseum    ${BASE_URL}
    ${response}=      GET On Session    Rijksmuseum    url=/${LANGUAGE}/collection/${OBJECT_ID}  expected_status=401
    Should Be Equal As Numbers    ${response.status_code}    405

#dummy commit