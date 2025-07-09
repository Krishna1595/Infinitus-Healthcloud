public with sharing class CareBenefitService {
    public static void sendRequest(CareBenefitVerifyRequest__c req) {
        Http http = new Http();
        HttpRequest httpReq = new HttpRequest();
        httpReq.setEndpoint('callout:CareBenefitAPI/benefit-verification-request');
        httpReq.setMethod('POST');
        httpReq.setHeader('Content-Type', 'application/json');
        Blob headerValue = Blob.valueOf('test_user:test_password');
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        httpReq.setHeader('Authorization', authorizationHeader);

        CareBenefitRequestWrapper payload = new CareBenefitRequestWrapper();
        payload.patient = new CareBenefitRequestWrapper.Patient();
        payload.patient.firstName = 'Test';
        payload.patient.lastName = 'Patient';
        payload.patient.dateOfBirth = Date.newInstance(1990, 01, 01);
        payload.patient.gender = 'Male';
        payload.insurance = new CareBenefitRequestWrapper.Insurance();
        payload.insurance.providerName = 'ABC Insurance';
        payload.insurance.policyNumber = '123456';
        payload.insurance.groupNumber = 'A1B2C3';
        payload.insurance.subscriberId = 'SUB123';
        payload.provider = new CareBenefitRequestWrapper.Provider();
        payload.provider.npi = '9876543210';
        payload.provider.firstName = 'Dr. John';
        payload.provider.lastName = 'Doe';
        payload.service = new CareBenefitRequestWrapper.Service();
        payload.service.serviceType = 'Consultation';
        payload.service.serviceDate = Date.today();
        payload.service.diagnosisCode = 'Z00.0';
        payload.service.procedureCode = '99201';

        httpReq.setBody(JSON.serialize(payload));
        try {
            HttpResponse res = http.send(httpReq);
            if (res.getStatusCode() == 200) {
                Map<String, Object> resMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                req.Status__c = (String) resMap.get('status');
                req.Status_Reason__c = (String) resMap.get('statusReason');
                update req;
            } else {
                System.debug('Failed: ' + res.getBody());
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
    }
}