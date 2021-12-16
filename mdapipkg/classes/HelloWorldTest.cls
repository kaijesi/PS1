@isTest
public class HelloWorldTest {
	
    @isTest static void updateLead() {

        // To be able to update a lead, we need to first create one
        Lead l = new Lead();

        // The following fields are required so we couldn't create the Lead without them
        l.FirstName = 'Test';
        l.LastName = 'Person';
        l.Company = 'Feel Good Inc.';
        
        // We need to specifically insert the lead as it doesn't exist yet
        insert l;
        
        // We now do a random update, which is what triggers the HelloWorld class
        l.Company = 'Feel Good Inc.';
        update l;

        // Test if the Name of the Lead is now 'Hello World'
        // Find the Lead and its First and Last Name
        Lead testLead = [SELECT FirstName, LastName FROM Lead WHERE Id = :l.Id];

        // Assert the two fields
        System.assertEquals('Hello', testLead.FirstName, 'First Name incorrect, should be Hello');
        System.assertEquals('World', testLead.LastName, 'Last Name incorrect, should be World');
        
    }
}