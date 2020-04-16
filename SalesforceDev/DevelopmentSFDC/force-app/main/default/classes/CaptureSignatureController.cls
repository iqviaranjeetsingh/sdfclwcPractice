global class CaptureSignatureController{
    public static id accountId{get;set;}
    public CaptureSignatureController(ApexPages.StandardController controller) {
       accountId = controller.getid();
    }

   @RemoteAction
     global static String saveSignature(String imageUrl, string accountId1) {
        System.debug('accountId:>>>>>'+accountId1+'imageUrl>>>>'+imageUrl);
        System.debug('Page Parameters:'+ApexPages.CurrentPage());
        try {
           Attachment accSign = new Attachment();
           accSign.ParentID = accountId1;
           accSign.Body = EncodingUtil.base64Decode(imageUrl);
           accSign.contentType = 'image/png';
           accSign.Name = 'Signature Image';
           accSign.OwnerId = UserInfo.getUserId();
           insert accSign;
           
           return 'success';
           
        }catch(Exception e){
           system.debug('---------- ' + e.getMessage());
           return JSON.serialize(e.getMessage());
        }
        return null; 
     }
}