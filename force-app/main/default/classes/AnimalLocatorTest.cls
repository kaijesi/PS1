@isTest 
public class AnimalLocatorTest {
    @isTest 
    static void testAnimalLocation() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String response = AnimalLocator.getAnimalNameById(1);
        System.debug(response);
        System.assertEquals('chicken', response, 'No chicken found. Cluck Cluck MFer!');
	}
    
    @isTest
    static void testAnimalLocationNoId() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMockNoId());
        String response = AnimalLocator.getAnimalNameById(null);
        System.debug(response);
        System.assertEquals(null, response);
	}
}    
