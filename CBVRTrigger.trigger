trigger CBVRTrigger on CareBenefitVerifyRequest__c (after insert) {
    for (CareBenefitVerifyRequest__c cbvr : Trigger.new) {
        CareBenefitService.sendRequest(cbvr);
    }
}