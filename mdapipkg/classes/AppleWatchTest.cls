@isTest
public class AppleWatchTest {
	
    @isTest static void createOpp() {
		// We create a new opp as this is what sets off the AppleWatch trigger
        Opportunity opp = new Opportunity();
        opp.Name = 'Raw Deal';
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        insert opp;
    }
    
    @isTest static void createOppHigh() {
        Opportunity opp = new Opportunity();
        opp.Name = 'Raw Deal';
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        opp.Amount = 50001;
        insert opp;
    }
    
    @isTest static void createOppLow() {
        Opportunity opp = new Opportunity();
        opp.Name = 'Raw Deal';
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today();
        opp.Amount = 1;
        insert opp;
    }
}