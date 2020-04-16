public with sharing class RESTAPICalloutPractice {
   public string selectedAnimal{get;set;}
   public string responseValues{get;set;}
   
   public pageReference StartCalloutUsingREST(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            List<Object> animals = (List<Object>) results.get('animals');
            System.debug('Received the following animals:');
            for (Object animal: animals) {
                if(String.isBlank(responseValues)){
                   responseValues = string.valueOf(animal)+' ;';
                }else{
                   responseValues +=animal+' ;';
                }
                
                System.debug(animal);
            }
        }
      return null;
   }
   
   public PageReference DoPostCallout(){
      postResponse = string.valueOf(RESTAPICalloutPractice.makePostCallout().getBody());
      return null;
   }
   
   public string postResponse{get;set;}
   
   public static HttpResponse makePostCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"mighty moose"}');
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }       
    
   
   public list<SelectOption> getAnimals(){
      list<SelectOption> option = new list<SelectOption>();
      option.add(new SelectOption('','--None--'));
      if(string.isNotBlank(responseValues)){
         for(string str:responseValues.split(';')){
            option.add(new SelectOption(str,str));
         }
      }
      
       return option;
   }
}