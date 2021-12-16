trigger CaseClosure on Case (before insert, before update) {
    for (Case newCase : Trigger.new)    {
        // Find out if there have been either more than 2 further cases created for the same Contact OR more than 3 cases for the same Account on the same day
        
        // Find out if the contact-based case limit is true
        // Only validate if the Contact lookup was filled out
        Boolean contactCondition = false;
        if (newCase.ContactId != null)  {
            List<Case> contactCases = [SELECT Id FROM Case WHERE ContactId = :newCase.ContactId AND CreatedDate = TODAY];
            if (contactCases.size() > 2)    {
                contactCondition = true;
            }
        }

        // Find out if the account-based case limit is true
        // Only validate if the Account lookup is filled out
        Boolean accountCondition = false;
        if (newCase.AccountId != null)  {
            List<Case> accountCases = [SELECT Id FROM Case WHERE AccountId = :newCase.AccountId AND CreatedDate = TODAY];
            if (accountCases.size() > 3)    {
                accountCondition = true;
            }
        }

        // If either of the conditions are true, set the case to 'Closed'
        if (contactCondition || accountCondition) {
            newCase.Status = 'Closed';
        }
    }

}