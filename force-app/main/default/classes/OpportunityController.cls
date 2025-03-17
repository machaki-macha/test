public with sharing class OpportunityController {

    public List<Opportunity> opportunityList {get; set;}

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunity(String searchKey){
        System.debug('get1');
        List<Opportunity> opportunityList = new List<Opportunity>();
        String key = '%' + searchKey + '%';
        opportunityList = [SELECT id,name,accountid,amount FROM Opportunity WHERE name LIKE :key];
        return opportunityList;
    }

    public void init(){
        System.debug('init');
        //getOpportunity2();
    }

    public List<Opportunity> getOpportunity2(){
        System.debug('get2');
        opportunityList = new List<Opportunity>();
        
        opportunityList = [SELECT id,name,accountid,amount FROM Opportunity ];
        System.debug(opportunityList);
        return opportunityList;
        
    }
}