public class AnimalLocator {
    public static String getAnimalNameById(Integer Id) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + Id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('HTTP GET Status: ' + response.getStatusCode());
        
        if(response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            System.debug(results);
            Map<String, Object> animal = (Map<String, Object>)results.get('animal');
            System.debug(animal);
            String animalName = string.valueOf(animal.get('name'));
            return animalName;
        }
        else {
            return null;
        }
	}
}