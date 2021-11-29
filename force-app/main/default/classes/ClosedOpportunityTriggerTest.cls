@isTest
public class ClosedOpportunityTriggerTest {
	
    @isTest static void createClosedWonOpp() {
        // Create a closed won opportunity to fire the trigger
        Opportunity opp = new Opportunity();

        // Set required fields
        opp.Name = 'Test';
        opp.CloseDate = Date.today();

        // Set stage name
        opp.StageName = 'Closed Won';

        insert opp;


        
    }
}
