@isTest
public class LeadingCompetitorTest {
	
    @isTest static void createOpp() {
        Opportunity opp = new Opportunity();
        
        // Required fields
        opp.Name = 'Test';
        opp.CloseDate = Date.today();
        opp.StageName = 'Prospecting';

        // Populate price fields
        opp.Competitor_1_Price__c = 1;
        opp.Competitor_2_Price__c = 2;
        opp.Competitor_3_Price__c = 3;

        // Populate name fields
        opp.Competitor_1__c = 'Amazon';
        opp.Competitor_2__c = 'Google';
        opp.Competitor_3__c = 'Microsoft';

        // Insert opportunity
        insert opp;
        
        // Check if leading competitor was filled out correctly
        Opportunity insertedOpp = [SELECT Leading_Competitor__c FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals('Amazon', insertedOpp.Leading_Competitor__c, 'Leading competitor incorrect');


    }
}