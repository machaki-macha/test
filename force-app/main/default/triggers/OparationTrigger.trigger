trigger OparationTrigger on test__c(before insert,before update) {
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            OperationTriggerHandler.beforeupdate();
            System.debug('beforeupdate');
        }
    }
}