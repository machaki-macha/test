public with sharing class OpportunityController2 {
    public class TableRow{
        public id id {get; set;}
        public String name {get; set;}
    }
    
    public String searchKey {get; set;}
    public List<Opportunity> opportunityList {get; set;}
    public List<TableRow> RowList {get; set;} 

    /*
    public OpportunityController2(ApexPages.StandardController stdController){

    }*/

    public Pagereference getOpportunity2(){      
        RowList = new List<TableRow>();
        TableRow tr;
        
        String key = '%' + searchKey + '%';
        opportunityList = [SELECT id,name FROM Opportunity WHERE name LIKE :key];

        /*
        for(Opportunity opp : [SELECT id,name FROM Opportunity WHERE name LIKE :key]){
            tr = new TableRow();
            tr.id = opp.id;
            tr.name = opp.name;
            RowList.add(tr);
        }*/
        return null;
    }
}