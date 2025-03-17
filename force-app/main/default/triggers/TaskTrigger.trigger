trigger TaskTrigger on Task__c (before insert, before update, after update){
    TaskTriggerHandler hndl = new TaskTriggerHandler();
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            hndl.beforeInsertTask(Trigger.new);
        }
        if(Trigger.isUpdate){
            hndl.beforeUpdateTask(Trigger.new);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            hndl.afterUpdateTask(Trigger.new,Trigger.oldMap);
        }
    }
}