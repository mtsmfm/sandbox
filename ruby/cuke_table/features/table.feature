Feature:
  Scenario:
    Given a table:
      | a | b | c |
      | 1 | 2 | 3 |
      | 2 | 3 | 4 |

    Then the table should match:
      | b | a |
      | 2 | 1 |
      | 3 | 2 |
    And the table should match:
      | b | a |
      | 3 | 1 |
