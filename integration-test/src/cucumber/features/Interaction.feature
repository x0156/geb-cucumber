Feature: Interaction features

Scenario: Enter values into basic fields
  When I go to the form page
  Then the name field has the value of "Ada Lovelace"
  And the favourite language field has value ''
  And the use gnat checkbox is not checked
  When I enter 'foo' into the name field
  And I select 'Ada95' in the favourite language field
  And I click the use gnat checkbox
  Then the name field has value 'foo'
  And the favourite language field has value 'Ada95'
  And the use gnat checkbox is checked

Scenario: Enter values into direct page fields using table syntax
  When I go to the form page
  When I enter the following values:
    | name           | favourite language | use gnat |
    | 'Ada Lovelace' | 'Ada95'            | checked  |
  Then the name field has value 'Ada Lovelace'
  And the favourite language field has value 'Ada95'
  And the use gnat checkbox is checked
  When I enter the following values:
    | name           | favourite language | use gnat  |
    | 'Donald Knuth' | 'Tex'              | unchecked |
  Then the page has the following values:
    | name           | favourite language | use gnat  |
    | 'Donald Knuth' | 'Tex'              | unchecked |

Scenario: Enter values into module fields using table syntax
  When I go to the form page
  When I enter the following values into the address section:
    | street address                 | city      | state | postcode | registered mail only |
    | 'Norwood Oval\n4 Woods Street' | 'Norwood' | 'SA'  | '5067'   | unchecked            |
  Then the address section street address field has value 'Norwood Oval\n4 Woods Street'
  Then the address section city field has value 'Norwood'
  Then the address section state field has value 'SA'
  Then the address section postcode field matches /\d{4}/
  Then the address section registered mail only box is not checked
  When I enter the following values into the address section:
    | street address     | city        | state | postcode | registered mail only |
    | '39 George Street' | 'Thebarton' | 'SA'  | '5031'   | checked              |
  Then the address section has the following values:
    | street address     | city        | state | postcode | registered mail only |
    | '39 George Street' | 'Thebarton' | 'SA'  | /\d{4}/   | checked              |

Scenario: Verify generic content
  When I go to the home page with parameters:
    | greeting   |
    | 'hi there' |
  Then the greeting is present
  And the greeting is visible
  And the greeting has value 'hi there'
  And the greeting field has value 'hi there'
  And the greeting string label has value 'hi there'

Scenario: Not present content
  When I go to the home page
  Then the greeting is not present

Scenario: Hidden content
  When I go to the home page with parameters:
    | greeting   | greetingHidden |
    | 'hi there' | 'true'         |
  Then the greeting is present
  And the greeting is not visible

Scenario: Enter values into page from a map variable using table syntax
  Given the programmer map variable has the following values:
    | full name    | lang    |
    | 'Bill Gates' | 'Basic' |
  When I go to the form page
  When I enter the following values from the programmer:
    | name      | favourite language |
    | full name | lang               |
  Then the name field has value 'Bill Gates'
  And the favourite language field has value 'Basic'
  And the page has the following values from the programmer:
    | name      | favourite language |
    | full name | lang               |

Scenario: Enter values into module fields from a map variable using table syntax
  Given the foo address map variable has the following values:
    | address lines                  | suburb    | state | zip      |
    | 'Norwood Oval\n4 Woods Street' | 'Norwood' | 'SA'  | '5067'   |
  When I go to the form page
  And I enter the following values into the address section from the foo address:
    | street address | city   | state | postcode |
    | address lines  | suburb | state | zip      |
  Then the address section street address field has value 'Norwood Oval\n4 Woods Street'
  And the address section city field has value 'Norwood'
  And the address section state field has value 'SA'
  And the address section postcode field matches /\d{4}/
  And the address section has the following values from the foo address:
    | street address | city   | state | postcode |
    | address lines  | suburb | state | zip      |
