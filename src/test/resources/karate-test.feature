Feature: Test de API súper simple

  Background:
    * configure ssl = true

  @id:1 @MUL-TEST-CA01-get-all-characters
  Scenario: Verificar que un endpoint público responde 200 OK
    Given url 'https://httpbin.org/get'
    When method get
    Then status 200

  @id:2 @MUL-TEST-CA02-get-all-characters
  Scenario: Verify get all characters endpoint responds 200 OK
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    When method get
    Then status 200


  @id:3 @MUL-TEST-CA03-post-character
  Scenario: Verify post character endpoint responds 200 OK
    * def rand = Math.floor(Math.random() * 100000)
    * def name = 'Chris Muyon ' + rand
    * def character =
      """
      {
        "name": "#(name)",
        "alterego": "Christian Muyon",
        "description": "Programmer and Karate enthusiast",
        "powers": ["Intelligence", "String"]
      }
      """
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And request character
    When method post
    Then status 201
