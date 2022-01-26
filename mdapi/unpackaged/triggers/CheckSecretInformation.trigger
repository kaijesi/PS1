/*
Trigger to evaluate whether a case's description contains certain keywords.
If it does, a child case should be created that describes this, is escalated and has high priority.
*/


// After insert as we need the Case Id to populate the child cases
trigger CheckSecretInformation on Case (after insert, before update) {
    
    // Create a set of words that should trigger closer investigation of the case
    Set<String> secretWords = new Set<String>();
    secretWords.add('Credit Card');
    secretWords.add('Social Security');
    secretWords.add('SSN');
    secretWords.add('Passport');
    secretWords.add('Bodyweight');

    System.debug('Set secretWords contains: ' + secretWords.size().format() + ' words.');
    
    // Create a list of cases where the description does contain one of the words
    List<Case> secretCases = new List<Case>();

    // Set the case subject for any child cases that will be created
    String caseSubject = 'WARNING: Parent contains potential PII violation';

    // Create a set of found keywords and a keyword found counter
    Set<String> foundKeywords = new Set<String>();
    Integer keywordCounter = 0;

    // Evaluate for every case if any of the keywords are mentioned in the description
    for (Case c : Trigger.new) {
        
        for (String keyword : secretWords) {
            // If there are any mentioned keywords, add the case to the list of cases for which a child case should be generated
            // Child cases created will have the list in their description, so make sure they will not be included
            if (c.Description != null && c.Subject != caseSubject && c.Description.contains(keyword)) {
                foundKeywords.add(keyword);
                keywordCounter++;

                System.debug('Case ' + c.Id + ' contains keyword ' + keyword);
            }
        }

        if (keywordCounter > 0) {
            secretCases.add(c);
        }
    }

    // Set up a list for all child cases to be created
    List<Case> childCases = new List<Case>();

    for (Case parent : secretCases) {
        Case child = new Case();
        child.Priority = 'High';
        child.ParentId = parent.Id;
        child.Subject = caseSubject;
        child.IsEscalated = true;
        child.Description = 'The following ' + keywordCounter.format() + ' prohibited keywords were found in the case description: ' + foundKeywords.toString().replace('{', '').replace('}', '');
        childCases.add(child);
    }

    insert childCases;

    
}