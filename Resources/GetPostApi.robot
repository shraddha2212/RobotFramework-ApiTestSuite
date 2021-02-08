*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Library    Collections
Resource    ../Input/InputData.robot

*** Variables ***
@{postKeyList}      userId      id      title       body
@{commentsKeyList}      postId      id      name        email       body

*** Keywords ***
GET API request
    [Arguments]    ${Uri}
    ${response}     GET On Session    jsonplaceholder      url=${Uri}
    [Timeout]    2 seconds
    [Return]    ${response}

GET API request with param
    [Arguments]    ${Uri}       ${QueryParam}
    ${response}     GET On Session    jsonplaceholder      url=${Uri}       params=${QueryParam}
    [Timeout]    2 seconds
    [Return]    ${response}

GET Json response
    [Arguments]    ${response}
    should be equal as strings    ${response.status_code},${response.reason}        ${GET_SUCCESS}
    ${jsonObject}  convert string to json    ${response.content}
    [Return]  ${jsonObject}

Get API Response For Post Route
    ${response}    Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}     GET API request      ${POST_RESOURCE}
    ${jsonResponse}     GET Json response    ${response}
    FOR     ${postobject}     IN    @{jsonResponse}
        ${unsortedPostKey}=        get dictionary keys     ${postobject}       sort_keys=False
        lists should be equal    ${unsortedPostKey}     ${postKeyList}
    END
    Verify Record Count      ${jsonResponse}       100

Get API response for post with different post ID
    [Arguments]    ${validPostId}
    FOR     ${postId}       IN      @{validPostId}
        ${response}     Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}        GET API request      ${POST_RESOURCE}${postId}
        ${jsonResponse}     GET Json response    ${response}
        ${post_id}   get value from json    ${jsonResponse}     $..id
        should be equal as strings    ${post_id}    ${postId}
    END

Get API response for post with invalid post ID
    [Arguments]    ${invalidPostID}
    FOR     ${postId}       IN      @{invalidPostId}
        ${err_msg}     run keyword and expect error        *       GET API request     ${POST_RESOURCE}${postid}
        should contain    ${err_msg}   ${GET_FAILURE_NOT_FOUND}
    END

GET API response for post to check all posts of specific user
    [Arguments]    ${validUserId}
    FOR     ${userId}       IN      @{validUserId}
        ${param}=       create dictionary    userId=${userId}
        ${response}     Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}        GET API request with param    ${POST_RESOURCE}       ${param}
        ${jsonResponse}     GET Json response    ${response}
        ${user_Id}   get value from json    ${jsonResponse}     $..userId
        Verify Record Count      ${jsonResponse}       10
            FOR     ${user}     IN      @{User_Id}
                should be equal as strings    ${user_Id}     ${userId}
            END

GET API response for post of incorrect user
    [Arguments]    ${incorrectUserId}
    FOR     ${userId}       IN      @{incorrectUserId}
        ${param}=       create dictionary    userId=${userId}
        Verify incorrect Query Param        ${POST_RESOURCE}        @{param}
    END

Get API response for post to check all comments
    [Arguments]     ${validPostID}
    FOR     ${postId}       IN      @{validPostId}
        log to console    ${postId}
        ${response}     Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}        GET API request      ${POST_RESOURCE}${postId}${COMMENTS_RESOURCE}
        ${jsonResponse}     GET Json response    ${response}
        Verify Record Count      ${jsonResponse}       5
        ${unsortedCommentKey}=        get dictionary keys      ${jsonResponse[0]}       sort_keys=False
        lists should be equal    ${unsortedCommentKey}     ${commentsKeyList}
        ${post_id}   get value from json    ${jsonResponse[0]}     $..postId
        should be equal as strings    ${post_id}    ${postId}
    END

Get API response to check post comment for invalid post ID
    [Arguments]    ${invalidPostID}
    FOR     ${postId}       IN      @{invalidPostId}
        ${response}     Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}        GET API request      ${POST_RESOURCE}${postid}${COMMENTS_RESOURCE}
        ${jsonResponse}     GET Json response    ${response}
        should be empty    ${jsonResponse}
    END

Check API response in case of incorrect post resource
    ${err_msg}     run keyword and expect error        *       GET API request      ${POST_RESOURCE}${INCORRECTRESOURCE}
    should contain    ${err_msg}   ${GET_FAILURE_NOT_FOUND}

GET post API response for specific title with query parameter
    [Arguments]    ${titleValue}
    ${param}=       create dictionary    title=${titleValue}
    ${response}     Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}        GET API request with param       ${POST_RESOURCE}     ${param}
    ${jsonResponse}     GET Json response    ${response}
    ${title}=   get value from json    ${jsonResponse}     $..title
    should be equal as strings    ${title[0]}    ${titleValue}

GET post API response for incorrect title with query parameter
    [Arguments]    ${incorrectTitleValue}
    ${param}=       create dictionary    title=${incorrectTitleValue}
    Verify incorrect Query Param        ${POST_RESOURCE}        ${param}

GET post API response for specific post ID and title with query parameter
    [Arguments]    ${postId}        ${titleValue}
    ${param}=       create dictionary    id=${postId[0]}    title=${titleValue}
    ${response}     Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}        GET API request with param       ${POST_RESOURCE}     ${param}
    ${jsonResponse}     GET Json response    ${response}
    ${title}=   get value from json    ${jsonResponse}     $..title
    should be equal as strings    ${title[0]}    ${titleValue}
    ${id}=   get value from json    ${jsonResponse}     $..id
    should be equal as strings    ${id[0]}    ${postId[0]}

GET post API response for incorrect post id and title with query parameter
    [Arguments]    ${incorrectPostId}        ${incorrectTitleValue}
    ${param}=       create dictionary    id=${incorrectPostId[0]}    title=${incorrectTitleValue}
    Verify incorrect Query Param        ${POST_RESOURCE}        ${param}

GET API response for post with specific email
    [Arguments]    ${postId}    ${validEmailId}
    ${param}=       create dictionary    email=${validEmailId}
    ${response}     Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}        GET API request with param       ${POST_RESOURCE}${postId[0]}${COMMENTS_RESOURCE}     ${param}
    ${jsonResponse}     GET Json response    ${response}
    ${emailId}=   get value from json    ${jsonResponse}     $..email
    should be equal as strings    ${emailId[0]}    ${validEmailId}

GET API response for all posts with incorrect email
    [Arguments]    ${postId}    ${incorrectEmailId}
    ${param}=       create dictionary    email=${incorrectEmailId}
    Verify incorrect Query Param        ${POST_RESOURCE}${postId[0]}${COMMENTS_RESOURCE}        ${param}

Verify incorrect Query Param
    [Arguments]    ${Uri}       ${Param}
    ${response}     Wait Until Keyword Succeeds   ${GLOBAL_RETRY_AMOUNT}    ${GLOBAL_RETRY_INTERVAL}        GET API request with param    ${Uri}       ${Param}
    ${jsonResponse}     GET Json response    ${response}
    should be empty    ${jsonResponse}

Verify Record Count
    [Arguments]    ${attribute}     ${expected}
    ${jsonLength}  get length    ${attribute}
    log to console    ${jsonlength}
    should be equal as strings    ${jsonLength}    ${expected}