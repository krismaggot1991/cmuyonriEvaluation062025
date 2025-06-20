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


  @id:3 @MUL-TEST-CA03-post-update-delete-and-not-found-character
  Scenario: Verify post character, update, delete, and verify deletion
    * def jsonreq = read('classpath:../data/request_UpdateCharacter.json')
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
    * def createdId = response.id
    * print 'ID creado:', createdId

    # Verificar que el personaje creado es actualizado
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/' + createdId
    And request jsonreq
    When method put
    Then status 200

    # Verificar que el personaje creado es eliminado
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/' + createdId
    When method delete
    Then status 204

    # Verificar que ya no existe
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters/' + createdId
    When method get
    Then status 404

  @id:5 @MUL-TEST-CA05-post-character-missing-name
  Scenario: Verificar que la creación falla si falta el campo name
    * def character =
      """
      {
        "alterego": "Sin Nombre",
        "description": "Falta el campo name",
        "powers": ["Unknown"]
      }
      """
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'
    And request character
    When method post
    Then status 400