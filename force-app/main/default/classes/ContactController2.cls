public with sharing class ContactController2 {
    private String sortOrder = 'LastName';
    public List<Contact> contactList {get; set;}

    //init 初期処理
    public void init(){
        getContacts1();
    }

    public List<Contact> getContacts1() {
    
        contactList = new List<Contact>();
        contactList = [SELECT Id, FirstName, LastName, Title, Email FROM Contact Limit 15 ];
        /*List<Contact> results = Database.query(
            'SELECT Id, FirstName, LastName, Title, Email ' +
            'FROM Contact ' +
            'ORDER BY ' + sortOrder + ' ASC ' +
            'LIMIT 10'
        );*/
        return contactList;
    }
}