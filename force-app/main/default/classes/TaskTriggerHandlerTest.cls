@isTest
public with sharing class TaskTriggerHandlerTest {

    @TestSetup
    static void setUp(){
        Account insAccount = new Account();
        Contact insContact = new Contact();
        Anken__c insAnken = new Anken__c();

        insAccount.Name = 'テスト取引先';
        insContact.FirstName = 'テスト';
        insContact.LastName = '責任者';
        insAnken.Name = 'テスト案件';
        insAnken.Account__c = insAccount.Id;
        insAnken.Contact__c = insContact.Id;
        insAnken.StartDate__c = Date.today();
        insAnken.EndDate__c = Date.today()+7;
        insAnken.Status__c = '新規';

        insert insAccount;
        insert insContact;
        insert insAnken;
    }

    /*
    * testMethod01
    * タスク作成
    * @param: 無し
    * @return: 無し
    */
    static testMethod void testMethod01(){

        Task__c insParentTask = new Task__c();

        //親タスク
        insParentTask = createTask(null,true);

        insParentTask.Progress__c = 50;
        update insParentTask;
        System.assertEquals(50, insParentTask.Progress__c);
        insParentTask.Progress__c = 80;
        update insParentTask;
        System.assertEquals(80, insParentTask.Progress__c);
        insParentTask.Progress__c = 100;
        update insParentTask;
        System.assertEquals(100, insParentTask.Progress__c);
    }

    /*
    * testMethod02
    * 親タスク更新
    * @param: 無し
    * @return: 無し
    */
    @isTest
    static void testMethod02(){
        
        Task__c insParentTask1 = new Task__c();
        Task__c insParentTask2 = new Task__c();
        Task__c insChildTask1 = new Task__c();
        Task__c insChildTask2 = new Task__c();
        List<Task__c> taskList = new List<Task__c>();
        List<Task__c> updateTaskList = new List<Task__c>();

        insParentTask1 = createTask(null,true);
        insParentTask2 = createTask(null,false);
        insParentTask2.Name = 'テストタスク２';
        insert insParentTask2;

        insChildTask1 = createTask(insParentTask1.id,false);
        insChildTask1.Name = 'テスト子タスク１';
        insert insChildTask1;
        insChildTask2 = createTask(insParentTask2.id,false);
        insChildTask2.Name = 'テスト子タスク２';
        insert insChildTask2;

        insParentTask1.Progress__c = 100;
        insParentTask1.Status__c = '完了';
        insParentTask2.Progress__c = 100;
        insParentTask2.Status__c = '完了';

        updateTaskList.add(insParentTask1);
        updateTaskList.add(insParentTask2);

        update updateTaskList;
        
        taskList = [SELECT id,Progress__c,Status__c FROM Task__c WHERE id = :updateTaskList];
        System.debug(taskList);

        for(Task__c task : taskList){
            //進捗
            System.assertEquals(100, task.Progress__c);
            //状況
            System.assertEquals('完了', task.Status__c);
        }
    }

    /*
    * testMethod03
    * 子タスク更新
    * @param: 無し
    * @return: 無し
    */
    @isTest
    static void testMethod03(){

        Task__c insParentTask1 = new Task__c();
        Task__c insParentTask2 = new Task__c();
        Task__c insChildTask1 = new Task__c();
        Task__c insChildTask2 = new Task__c();
        Task__c insChildTask3 = new Task__c();
        Task__c insChildTask4 = new Task__c();
        List<Task__c> taskList = new List<Task__c>();
        List<Task__c> updateTaskList = new List<Task__c>();

        insParentTask1 = createTask(null,true);
        insParentTask2 = createTask(null,false);
        insParentTask2.Name = 'テストタスク２';
        insert insParentTask2;

        insChildTask1 = createTask(insParentTask1.id,false);
        insChildTask1.Name = 'テスト子タスク１';
        insert insChildTask1;
        insChildTask2 = createTask(insParentTask2.id,false);
        insChildTask2.Name = 'テスト子タスク２';
        insert insChildTask2;
        insChildTask3 = createTask(insParentTask1.id,false);
        insChildTask3.Name = 'テスト子タスク３';
        insChildTask3.Progress__c = 100;
        insChildTask3.Status__c = '完了';
        insert insChildTask3;
        insChildTask4 = createTask(insParentTask2.id,false);
        insChildTask4.Name = 'テスト子タスク４';
        insChildTask4.Progress__c = 100;
        insChildTask4.Status__c = '完了';
        insert insChildTask4;

        insChildTask1.Progress__c = 100;
        insChildTask1.Status__c = '完了';
        insChildTask2.Progress__c = 100;
        insChildTask2.Status__c = '完了';

        updateTaskList.add(insChildTask1);
        updateTaskList.add(insChildTask2);

        update updateTaskList;
        
        taskList = [SELECT id,Progress__c,Status__c FROM Task__c WHERE id = :updateTaskList];
        System.debug(taskList);

        for(Task__c task : taskList){
            //進捗
            System.assertEquals(100, task.Progress__c);
            //状況
            System.assertEquals('完了', task.Status__c);
        }
    }

    /*
    * createTask
    * タスクレコード作成
    * @param:parentTaskId　親タスクレコードID
    * @param:insFlg　insert実行フラグ(False:実行しない、True:実行)
    * @return:タスクレコード 
    */
    static Task__c createTask(Id parentTaskId, Boolean insFlg){

        Task__c insTask = new Task__c();

        insTask.Name = 'テストタスク';
        insTask.PlanStartDate__c = date.today();
        insTask.PlanEndDate__c = date.today()+7;
        insTask.Priority__c = '低';
        insTask.Progress__c = 0;
        insTask.Status__c = '未着手';
        if(!String.isEmpty(parentTaskId)){
            insTask.ParentTask__c = parentTaskId;
        }
        if(insFlg)insert insTask;
        return insTask;
    }
}