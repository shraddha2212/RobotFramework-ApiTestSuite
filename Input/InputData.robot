*** Variables ***
#Configuration
${BASE_URL}     http://jsonplaceholder.typicode.com
${POST_RESOURCE}    posts/
${COMMENTS_RESOURCE}     /comments
${INCORRECTRESOURCE}        /comment
${GLOBAL_RETRY_AMOUNT}      3x
${GLOBAL_RETRY_INTERVAL}    0.5s
${GET_SUCCESS}      200,OK
${GET_FAILURE_NOT_FOUND}    HTTPError: 404 Client Error: Not Found

#InputData
@{VALID_POSTID}      1       4
@{INVALID_POSTID}    101     -102
@{VALID_USERID}     1       10
@{INCORRECT_USERID}       11      12
${POST_TITLE}        sunt aut facere repellat provident occaecati excepturi optio reprehenderit
${INCORRECT_POST_TITLE}     @abcd
${EMAIL}        Hayden@althea.biz
${INCORRECT_EMAIL}      abc@gmail.com


