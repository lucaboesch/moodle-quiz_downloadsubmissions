@quiz @quiz_downloadsubmissions
Feature: Test all the basic functionality of this quiz report
  In order to evaluate students responses, As a teacher I need to
  download essay question submissions.

  Background:
    Given the following "users" exist:
      | username |
      | teacher  |
      | student  |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "activities" exist:
      | activity | name      | course | idnumber |
      | quiz     | Test quiz | C1     | quiz1    |
    And the following "course enrolments" exist:
      | user    | course | role           |
      | teacher | C1     | editingteacher |
      | student | C1     | student        |
    And the following "question categories" exist:
      | contextlevel | reference | name           |
      | Course       | C1        | Test questions |
    And the following "blocks" exist:
      | blockname     | contextlevel | reference | pagetypepattern | defaultregion |
      | private_files | System       | 1         | my-index        | side-post     |
    And the following "questions" exist:
      | questioncategory | qtype | name      | template         |
      | Test questions   | essay | essay-001 | editorfilepicker |
    And quiz "Test quiz" contains the following questions:
      | essay-001 | 1 |

  @javascript
  Scenario: Submit a file to an essay question as student and download the file as teacher
    Given the following "user private file" exists:
      | user     | student                                                         |
      | filepath | mod/quiz/report/downloadsubmissions/tests/fixtures/testfile.txt |
    When I am on the "Test quiz" "quiz activity" page logged in as "student"
    And I press "Attempt quiz"
    And I should see "You can drag and drop files here to add them."
    And I click on "Add..." "button"
    And I click on "Private files" "link" in the ".fp-repo-area" "css_element"
    And I follow "testfile.txt"
    And I should see "testfile.txt"
    And I click on "Select this file" "button"
    And I follow "Finish attempt ..."
    And I press "Submit all and finish"
    And I click on "Submit all and finish" "button" in the "Submit all your answers and finish?" "dialogue"
    And I log out

    # Basic check of the download submissions report
    And I am on the "Test quiz" "quiz_downloadsubmissions > Download essay submissions" page logged in as "teacher"
    Then I should see "Download"