Feature: To create end to end scenario for all the 5 http methods


  Background: To set the base path
    Given url 'http://localhost:9191'

  Scenario: End to end scenario
    # Creating random job id
    Given def getRandomValue = function(){return Math.floor((Math.random()*(100)))}
    And def id = getRandomValue()
    And print id
    # Post Method - To create id
    Given path '/normal/webapi/add'
    And request {"jobId":'#(id)',"jobTitle":"Telus Engg","jobDescription":"To develop Civil application","experience":["Telus","Apple","Mobile Iron"],"project":[{"projectName":"Telus App","technology":["Telus","SQL Lite","Gradle"]}]}
    And headers {Content-Type:'application/json', Accept:'application/json'}
    When method post
    Then status 201
    And print response
    # Update the all values using job id
    Given path '/normal/webapi/update'
    And request {"jobId":'#(id)',"jobTitle":"IT","jobDescription":"To develop IT application","experience":["IT","Apple","Mobile Iron"],"project":[{"projectName":"Telus App","technology":["IT","SQL Lite","Gradle"]}]}
    And headers {Content-Type:'application/json', Accept:'application/json'}
    When method put
    Then status 200
    And print response
    # Partial update
    Given path '/normal/webapi/update/details'
    And params {id:'#(id)',jobTitle:'CS',jobDescription:'CS Application'}
    And header Accept = 'application/json'
    When method patch
    Then status 200
    And print response
    # print the all job details
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get # send the get request
    Then status 200 # response status code
    And print response
    # Delete the job id
    Given path '/normal/webapi/remove/'+ id
    When method delete
    Then status 200
    And print response
    # check status after deleting - 404 error
    Given path '/normal/webapi/remove/'+ id
    When method delete
    Then status 404
    And print response
