# Salesforce Care Benefit Verification App

This is a Salesforce Health Cloud integration application that sends Care Benefit Verification Requests to an external API and handles responses via a REST callback.

---

Features

- Sends POST request to a Benefit Verification API
- Creates related CoverageBenefit__c records on receiving callback
- Utilizes Named Credential for authentication
- Trigger auto-sends request upon record insertion
- Includes Apex test class for REST callback logic

---

Metadata Components

- Custom Objects: `CareBenefitVerifyRequest__c`, `CoverageBenefit__c`
- Apex Classes: `CareBenefitRequestWrapper`, `CareBenefitService`, `CareBenefitVerificationAPI`
- Apex Trigger: `CBVRTrigger`
- Named Credential: `CareBenefitAPI`
- REST Endpoint: `/care-benefit-verification-results`

---

 Setup Instructions

Prerequisites

- Salesforce DX (SFDX CLI)
- Developer Org or Scratch Org
- Git installed
- Workbench access

---

