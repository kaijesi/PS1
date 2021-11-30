@isTest
public class MultiSelectPicklistChoiceCounterTest {
	
    @isTest static void createAccount() {
        Account acc = new Account();
        acc.Name = 'Test';
        // The created account has to have at least one ice cream flavour selected for all lines of code to run
        acc.Ice_Cream_Flavours__c = 'Strawberry';
        insert acc;
    }
}
