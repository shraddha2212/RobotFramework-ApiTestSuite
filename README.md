## Introduction

This repository contains a Robot Framework API test suite for GET requests scenarios against /posts route of http://jsonplaceholder.typicode.com.

It contains test suite execution report in HTML format (report.html) under Results folder.

## Installation

Follow below steps for installation:

    - Install Python 3 , if it is already installed move on to next step
    - Clone or download this repository
    - Using the command line navigate to project folder and execute below command
```
         pip install -r requirements.txt
```
    - Above command will install robot framework and required supporting library's and their dependancies.

## Usage

    - Once everything has been installed you can run test suite from the command line/terminal in the projects folder with below command.

```
            robot -d Results Tests
```
    - Once execution is complete under results directory html report(report.html) for the test suite will be generated.

    - This test suite contains test cases with two tags one for post Route and one for post comments route.
    - Command to execute tests based on tag is :
```
            robot -d Results -i postRoute Tests
            robot -d Results -i postCommentsRoute Tests
```
## Test Cases

**Test Setup:** 

    - Timeout : Default timeout set for each GET request is 2 seconds
    - Retry count and Retry Interval : Each failed/timed out request will be retried for maximum of 3 times on an interval of 0.5s.
 
Sr. No | Test Case | Expected | Test Data | Endpoint |
--- | --- | --- | --- | ---
1 | To verify all posts for all users and validate response with fields | 1. Validate 200 success response is returned 2. Posts for all users should be displayed as mentioned on link check 100 posts are present 3. All 4 attributes (userId,id,title,body) of json object should be present| |http://jsonplaceholder.typicode.com/posts/
2 | Fetch post details based on post ID and validate id in response | 1. Validate 200 success response is returned 2. Response should display post only for mentioned id.| Valid post IDs  1, 4, 11 | http://jsonplaceholder.typicode.com/posts/{postid}
3 | To verify posts response in case of invalid post ID | Validate 404 Not Found response is returned for invalid post id | Invalid post Ids  101, -102 | http://jsonplaceholder.typicode.com/posts/{Invalidpostid}
4 | Verify posts for specific user and validate number of records | 1. Validates 200 success response along with userid 2. Checks number of records fetched are 10 | Valid User Ids  1, 10 | http://jsonplaceholder.typicode.com/posts?userId={userId}
5 | Verify posts response for incorrect user | Validate 200 Success is returned with empty response | Incorrect User Ids 11 12 | http://jsonplaceholder.typicode.com/posts?userId={IncorrectuserId}
6 | Verify all post comments are getting displayed for provided post ID | 1. Validate 200 success response is returned 2. Verify post comments are returned for mentioned post id 3. All 5 attributes (postId,id,name,email ,body) of json object should be present| Valid post IDs  1, 4, 11 | http://jsonplaceholder.typicode.com/posts/{validpostid}/comments
7 | Verify response for post comments with invalid post ID | Validate 200 Success is returned with empty response | Invalid post Ids  101, -102 | http://jsonplaceholder.typicode.com/posts/{Incorrectpostid}/comments
8 | To check API response for post in case of incorrect route resource | Validate 404 Not Found response is returned for invalid post id | Invalid resource /comment | http://jsonplaceholder.typicode.com/posts/{validpostid}/comment
9 | Check post for specific title with query parameter | Validate 200 success is returned and JSON response should contain specified title  | Valid title – ‘qui est esse’ | http://jsonplaceholder.typicode.com/posts?title={title}
10 | Check post for invalid title with query parameter | Validate 200 Success is returned with empty response | Invalid title - '@abcd' | http://jsonplaceholder.typicode.com/posts?title={incorrect_title}
11 | Check post for specific post ID and title with query parameter | Validate 200 Success is returned with post ID and title in response | post id=1 , title=‘qui est esse’ | http://jsonplaceholder.typicode.com/posts?id={id}&title={title}
12 | Check post for incorrect post id and title with query parameter | Validate 200 Success is returned with empty response | Incorrect post id=101 , incorrect title=‘@abcd’ | http://jsonplaceholder.typicode.com/posts?id={incorrectid}&title={incorrecttitle}
13 | Check post comments for specific email id with query parameter | Validate 200 Success is returned with correct email id in response |email=Eliseo@gardner.biz | http://jsonplaceholder.typicode.com/posts?email={email}
14 | Check post comments response for incorrect email with query parameter | Validate 200 Success is returned with empty response | Incorrect email='abc@gmail.com' | http://jsonplaceholder.typicode.com/posts?email={incorrectEmail}

  

