@isTest
public class CaseClosureTest {

    @isTest static void conditionsFulfilled() {

        // Create four cases for the same Contact and Account (to fulfill both conditions for case closure)
        // Create the contact
        Contact commonContact = new Contact();
        commonContact.LastName = 'Test Contact';
        insert commonContact;

        // Create the account
        Account commonAccount = new Account();
        commonAccount.Name = 'Test Account';
        insert commonAccount;

        // Create the cases
        List<Case> contactCases = new List<Case>();
        for (Integer i = 0; i < 4; i++) {
            Case c = new Case();
            c.Status = 'New';
            c.Origin = 'Phone';
            c.ContactId = commonContact.Id;
            c.AccountId = commonAccount.Id;
            contactCases.add(c);
        }
        insert contactCases;

        // Create the final case
        Case testCase = new Case();
        testCase.Status = 'New';
        testCase.Origin = 'Phone';
        testCase.ContactId = commonContact.Id;
        testCase.AccountId = commonAccount.Id;
        insert testCase;

        // Look for the new value of the testCase's Status, check if it's 'Closed'
        Case testCaseUpdated = [SELECT Status FROM Case WHERE Id = :testCase.Id];
        System.assertEquals('Closed', testCaseUpdated.Status, 'Status not correctly updated');
    }
}
