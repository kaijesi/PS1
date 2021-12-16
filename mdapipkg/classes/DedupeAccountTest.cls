@isTest
public class DedupeAccountTest {
    
    @isTest static void createAccount() {
        Account acc = new Account();
        acc.Name = 'Feel Good Inc.';
        insert acc;

        // Check if a new dedupe case with the correct information was created for this Account
        List<Case> testCase = [SELECT Subject, Account.Id, OwnerId FROM Case WHERE AccountId = :acc.Id];

        // Check if only one case was created
        System.assert(testCase.size() == 1, 'More than one case created');
        
        // Check if the case contains the correct data
        for (Case c : testCase) {
            System.assertEquals('Dedupe this account', c.Subject, 'Subject incorrect');
            System.assertEquals(acc.Id, c.AccountId, 'Linked to wrong Account');
        }

    }
}