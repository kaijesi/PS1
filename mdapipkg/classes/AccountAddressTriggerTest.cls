@isTest
public class AccountAddressTriggerTest {
	
    @isTest static void createAccount() {
        Account acc = new Account();
        // Create an Account for which the Match Billing Address checkbox is checked
        
        // Required field 'Name'
        acc.Name = 'Test';

        // Checkbox field true
        acc.Match_Billing_Address__c = true;

        insert acc;
    }
}
