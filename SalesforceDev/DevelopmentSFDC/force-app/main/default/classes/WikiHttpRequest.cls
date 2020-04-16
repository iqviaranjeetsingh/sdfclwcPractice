public class WikiHttpRequest {

    @AuraEnabled
    public static String getWikiResponse(String searchText, Integer searchLimit){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://en.wikipedia.org/w/api.php?action=opensearch&amp;search='+searchText+'&amp;limit='+
                        searchLimit+'&amp;namespace=0&amp;format=json');
		req.setMethod('GET');
        
        Http http = new Http();
		HTTPResponse res = http.send(req);  
		return res.getBody();
    }
}