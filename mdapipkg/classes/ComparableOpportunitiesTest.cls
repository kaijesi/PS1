@isTest
public class ComparableOpportunitiesTest {
	
    @isTest static void noComparableOpps() {
        // Test the trigger for when no comparable Opps are found
        Opportunity uniqueOpp = new Opportunity();
        uniqueOpp.Amount = 10000;
        uniqueOpp.Name = 'Test Opp';
        uniqueOpp.StageName = 'Prospecting';
        uniqueOpp.CloseDate = Date.today();
        insert uniqueOpp;

        // Check if there are no comparable opps in the related list
        List<Comparable_Opportunity__c> comparableOpps = [SELECT Id FROM Comparable_Opportunity__c WHERE Base_Opportunity__c = :uniqueOpp.Id];
        System.assertEquals(0, comparableOpps.size(), 'List of comparable Opps should be empty');
    }

    @isTest static void multipleComparableOpps() {
        // Test the trigger for when there are more than one comparable Opportunity
        
        // Set up a fake Account so all Opps will have the same industry
        Account industryAccount = new Account();
        industryAccount.Name = 'Feel Good Inc.';
        industryAccount.Industry = 'Electronics';
        insert industryAccount;

        // Set the shared values
        Decimal amount = 10000;
        Date closeDate = Date.today().addYears(-1);

        // Set and insert a list of Opps that fulfil requirements
        List<Opportunity> comparableOpps = new List<Opportunity>();
        for (Integer i = 0; i < 2; i++) {
            Opportunity comparableOpp = new Opportunity();
            comparableOpp.Name = 'Test Opp';
            comparableOpp.Amount = amount;
            comparableOpp.CloseDate = closeDate;
            comparableOpp.StageName = 'Closed Won';
            comparableOpp.AccountId = industryAccount.Id;
            comparableOpps.add(comparableOpp);
        }
        insert comparableOpps;

        // Set and insert an opp that will get these two in its comparable list
        Opportunity newOpp = new Opportunity();
        newOpp.Name = 'Test Opp';
        newOpp.Amount = amount;
        newOpp.CloseDate = Date.today();
        newOpp.AccountId = industryAccount.Id;
        newOpp.StageName = 'Prospecting';
        insert newOpp;

        // Check if there are two comparable Opps records created
        List<Comparable_Opportunity__c> comparablesList = [SELECT Base_Opportunity__c, Comparable_Opportunity__c FROM Comparable_Opportunity__c WHERE Base_Opportunity__c = :newOpp.Id];
        System.assertEquals(2, comparablesList.size(), 'List should contain two elements');

        

    }
}
