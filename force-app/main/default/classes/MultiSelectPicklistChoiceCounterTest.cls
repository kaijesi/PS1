@isTest
public class MultiSelectPicklistChoiceCounterTest {
	
    @isTest static void createAccount() {
        Account acc = new Account();
        acc.Name = 'Test';
        // The created account has to have at least one ice cream flavour selected for all lines of code to run
        acc.Ice_Cream_Flavours__c = 'Strawberry;Chocolate';
        insert acc;

        // Check if the counter is correct
        Account checkAccount = [SELECT Flavour_Counter__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(2, checkAccount.Flavour_Counter__c, 'Multi-select counter not resulting in correct number');
    }
}
