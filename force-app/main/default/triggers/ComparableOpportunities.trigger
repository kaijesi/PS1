trigger ComparableOpportunities on Opportunity (after insert) {
    for (Opportunity newOpp : Trigger.new) {
        
        // Find similar Opps
        if (newOpp.Amount != null)  {

            // Similar Opp's Amount needs to be within these bounds
            Decimal lowerBound = newOpp.Amount * 0.9;
            Decimal upperBound = newOpp.Amount * 1.1;
            
            // New Opp's Account.Industry not in Trigger.new (as it is based on lookup to Account), therefore, we request it here
            Opportunity newOppIndustry = [SELECT Account.Industry FROM Opportunity WHERE Id = :newOpp.Id LIMIT 1];

            // Get list of similar Opps
            List<Opportunity> similarOpps = [SELECT Id 
                                            FROM Opportunity 
                                            WHERE Amount >= :lowerBound
                                            AND Amount <= :upperBound
                                            AND Account.Industry = :newOppIndustry.Account.Industry
                                            AND StageName = 'Closed Won'
                                            AND CloseDate = LAST_YEAR];

            // For each similar opp, we want to create one junction record of type Comparable Opportunity
            // Set up list first
            List<Comparable_Opportunity__c> comparableOpps = new List<Comparable_Opportunity__c>();
            
            // Then fill list with one Comparable Opportunity record for each similar Opportunity
            for (Opportunity similarOpp : similarOpps)  {
                Comparable_Opportunity__c comparableOpp = new Comparable_Opportunity__c();
                comparableOpp.Base_Opportunity__c = newOpp.Id;
                comparableOpp.Comparable_Opportunity__c = similarOpp.Id;
                comparableOpps.add(comparableOpp);
            }

            // Insert the comparable Opps
            insert comparableOpps;
        }
        

    }

}