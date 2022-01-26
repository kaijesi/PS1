trigger DedupeLead on Lead (before insert) {

    // Get the Data Quality Queue record Id
    Group dataQualityQueue = [SELECT    Id 
                                FROM    Group 
                               WHERE    Type = 'Queue' 
                                 AND    Name = 'Data Quality' 
                               LIMIT    1];

    // Only proceed if the Data Quality queue exists
    if (dataQualityQueue != null)   {

        // For each lead, find a list of contacts with the same Email
        for (Lead lead : Trigger.new)   {

            // Only proceed if the Lead's Email is filled out
            if (lead.Email != null) {
                
                // Define search strings for SOQL
                String companyNameSearch = '%' + lead.Company + '%';
                String firstNameSearch = lead.FirstName.substring(0,1) + '%';
                
                // Find potential duplicate Contacts
                List<Contact> potentialDupes = [SELECT  Id, Name 
                                                FROM    Contact 
                                                WHERE   Email = :lead.Email
                                                OR      (LastName = :lead.LastName
                                                AND      FirstName LIKE :firstNameSearch
                                                AND      Account.Name LIKE :companyNameSearch)];

                System.debug('Dupes found: ' + potentialDupes);

                // If at least one Contact was found, assign the Lead to the Data Quality Queue                                
                if (potentialDupes.size() > 0)   {
                    lead.OwnerId = dataQualityQueue.Id;
                    System.debug('Owner Changed to DQ queue: ' + dataQualityQueue.Id);
                    String leadDescription = 'Potential duplicates: \n';
                    for (Contact dupeContact : potentialDupes)  {
                        leadDescription += dupeContact.Name + '\n' 
                        + URL.getSalesforceBaseUrl().toExternalForm() 
                        + '/lightning/r/' + dupeContact.Id + '/view' + '\n';
                    }
                    lead.Description = leadDescription;
                }
            }
            
        }
    }
    

}