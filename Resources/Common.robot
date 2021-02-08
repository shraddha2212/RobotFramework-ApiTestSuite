*** Settings ***
Library     RequestsLibrary
Resource    ../Input/InputData.robot

*** Keywords ***
Suite Setup
    Create Session    jsonplaceholder    ${BASE_URL}

Suite Teardown
    Delete All Sessions