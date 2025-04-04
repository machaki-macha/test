public inherited sharing class LWCExampleController {

    @AuraEnabled(Cacheable = true)
    public static List<Contact> getContacts() {
        return [SELECT Id, Name, FirstName, LastName, Phone, Email 
                FROM Contact 
                WHERE Email != null 
                AND Phone != null 
                ORDER BY CreatedDate DESC NULLS LAST limit 10];
    }
}