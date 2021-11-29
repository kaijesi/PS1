@isTest
public class CheckSecretInformationTest {
	
    @isTest static void createCase() {
        // Create a case where the description contains a keyword that's on the prohibit list
        Case c = new Case();
        
        // Set required fields
        c.Status = 'New';
        c.Origin = 'Phone';

        // Set description to contain prohibited word
        c.Description = 'Credit Card';

        insert c;
    }
}

