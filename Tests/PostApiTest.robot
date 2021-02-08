*** Settings ***
Documentation   To verify HTTP GET requests scenarios for /posts route.
Library     RequestsLibrary
Library    JSONLibrary
Resource    ../Input/InputData.robot
Resource    ../Resources/GetPostApi.robot
Resource    ../Resources/Common.robot
Suite Setup     Suite Setup
Suite Teardown    Suite Teardown

*** Test Cases ***
To verify all posts for all users and validate response fields
    [Documentation]     Validates success response along with all fields and record count 100
    [Tags]    postRoute
    Get API Response For Post Route

Fetch post details based on post ID and validate ID in response
    [Documentation]    Validates success retuned along with postid in response
    [Tags]    postRoute
    Get API response for post with different post ID       ${VALID_POSTID}

To verify posts response in case of invalid post ID
    [Documentation]    Validates 404 Not Found Response
    [Tags]    postRoute
    Get API response for post with invalid post ID      ${INVALID_POSTID}

Verify posts for specific user and validate number of records
    [Documentation]    Validates success response along with userid and number of records as 10
    [Tags]    postRoute
    GET API response for post to check all posts of specific user    ${VALID_USERID}

Verify posts response for incorrect user
    [Documentation]    Validates success response with empty response
    [Tags]    postRoute
    GET API response for post of incorrect user    ${INCORRECT_USERID}

Verify all post comments are getting displayed for provided post ID
    [Documentation]     Takes multiple input and checks comments for each post id
    [Tags]    postCommentsRoute
    Get API response for post to check all comments        ${VALID_POSTID}

Verify response for post comments with invalid post ID
    [Documentation]     Takes multiple invalid input and validates empty response
    [Tags]    postCommentsRoute
    Get API response for post with invalid post ID      ${INVALID_POSTID}

To check API response for post in case of incorrect post route resource
    [Documentation]     Varifies 404 Not found response for incorrect post resource
    [Tags]    postRoute
    Check API response in case of incorrect post resource

Check post for specific title with query parameter
    [Documentation]    verifies success response along with title verification
    [Tags]      postRoute
    GET post API response for specific title with query parameter    ${POST_TITLE}

Check post for incorrect title with query parameter
    [Documentation]     verifies success along with empty response
    [Tags]    postRoute
    GET post API response for incorrect title with query parameter    ${INCORRECT_POST_TITLE}

Check post for specific post ID and title with query parameter
    [Documentation]     verifies success along with postid and title in response
    [Tags]    postRoute
    GET post API response for specific post ID and title with query parameter   ${VALID_POSTID}     ${POST_TITLE}

Check post for incorrect post id and title with query parameter
    [Documentation]    Verifies success along with empty response
    [Tags]    postRoute
    GET post API response for incorrect post id and title with query parameter  ${INVALID_POSTID}   ${INCORRECT_POST_TITLE}

Check post comments for specific email id with query parameter
    [Documentation]    Verifies success response along with email id in response
    [Tags]    postCommentsRoute
    GET API response for post with specific email         ${VALID_POSTID}       ${EMAIL}

Check post comments response for incorrect email with query parameter
    [Documentation]     verifies success along with empty response
    [Tags]    postCommentsRoute
    GET API response for all posts with incorrect email     ${VALID_POSTID}         ${INCORRECT_EMAIL}
