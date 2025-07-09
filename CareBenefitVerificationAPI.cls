@RestResource(urlMapping='/care-benefit-verification-results')
global with sharing class CareBenefitVerificationAPI {
    @HttpPost
    global static void receiveCallback() {
        RestRequest req = RestContext.request;
        String body = req.requestBody.toString();
        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(body);
        String status = (String) response.get('status');
        String statusReason = (String) response.get('statusReason');
        List<CareBenefitVerifyRequest__c> cbvrList = [SELECT Id FROM CareBenefitVerifyRequest__c LIMIT 1];
        if (!cbvrList.isEmpty()) {
            CoverageBenefit__c cb = new CoverageBenefit__c(
                CareBenefitVerifyRequest__c = cbvrList[0].Id,
                Status__c = status,
                Status_Reason__c = statusReason
            );
            insert cb;
        }
    }
}