public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [
            SELECT
                Id,
                Name,
                FirstName,
                LastName,
                Title,
                Phone,
                Email,
                Picture__c
            FROM Contact
            WHERE Picture__c != NULL
            WITH USER_MODE
            LIMIT 10
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> findContacts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
            SELECT Id, Name, Title, Phone, Email, Picture__c
            FROM Contact
            WHERE Name LIKE :key AND Picture__c != NULL
            WITH USER_MODE
            LIMIT 10
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Contact getSingleContact() {
        return [
            SELECT Id, Name, Title, Phone, Email, Picture__c
            FROM Contact
            WITH USER_MODE
            LIMIT 1
        ];
    }

    @AuraEnabled
    public static void updateContacts(List<Contact> contactsForUpdate) {
        // Make sure we can update the database before trying to update
        if (!Schema.sObjectType.Contact.isUpdateable()) {
            throw new SecurityException(
                'Insufficient permissions to update contacts'
            );
        }
        update contactsForUpdate;
    }

    @AuraEnabled
    public static void updateContact(
        Id recordId,
        String firstName,
        String lastName
    ) {
        Contact contact = new Contact(
            Id = recordId,
            FirstName = firstName,
            LastName = lastName
        );
        update contact;
    }

    public static List<Contact> getContacts(String accountId) {
        /**
         * Validate CRUD permission before SOQL/DML operation (rule: Security-ApexCRUDViolation)
         * See: https://pmd.github.io/latest/pmd_rules_apex_security.html#apexcrudviolation
         */
        // if (!Schema.sObjectType.Contact.isAccessible()) {
        //   return new List<Contact>();
        // }
        List<Contact> contacts = [
          SELECT Id, Name, Title
          FROM Contact
          WHERE AccountId = :accountId
          ORDER BY Name ASC
        ];
        return contacts;
      }
}