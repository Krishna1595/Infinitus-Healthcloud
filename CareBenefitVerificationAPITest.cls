@isTest
private class CareBenefitVerificationAPITest {
    @isTest static void testReceiveCallback() {
        CareBenefitVerifyRequest__c req = new CareBenefitVerifyRequest__c(
            External_ID__c = 'EXTERNAL123',
            Status__c = 'Pending'
        );
        insert req;
        String callbackJSON = '{"status": "Acknowledged", "statusReason": "Verified successfully"}';
        RestRequest restReq = new RestRequest();
        restReq.requestBody = Blob.valueOf(callbackJSON);
        RestContext.request = restReq;
        RestContext.response = new RestResponse();
        Test.startTest();
        CareBenefitVerificationAPI.receiveCallback();
        Test.stopTest();
        List<CoverageBenefit__c> benefits = [SELECT Id, Status__c FROM CoverageBenefit__c];
        System.assert(!benefits.isEmpty(), 'Coverage Benefit should be created');
        System.assertEquals('Acknowledged', benefits[0].Status__c);
    }
}