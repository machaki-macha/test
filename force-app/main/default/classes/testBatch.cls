public abstract class testBatch implements Database.Batchable <SObject>{

    public String query;

    public abstract void accountSearch(Database.BatchableContext bc);

    public Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('***start***');
        System.debug(bc);
        //String query = 'Select id FROM Contact LIMIT 3';
        try{
            accountSearch(bc);
        }catch(Exception e){

        }

        System.debug('query文' + query);
        System.debug('query中身' + Database.getQueryLocator(query));
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<SObject> scope){
        System.debug('***execute***');
        System.debug(bc);
        System.debug(scope);
    }
    public void finish(Database.BatchableContext bc){
        System.debug('***finish***');
        System.debug(bc);
    }
}