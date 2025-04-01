/*
 * TaskTriggerhandler
 * タスクオブジェクトトリガハンドラクラス
 * テスト
 */
public class TaskTriggerHandler{
    // タスク状況項目選択肢「未着手」
    private static final String STATUS_NOTYET = '未着手';
    // タスク状況項目選択肢「進行中」
    private static final String STATUS_PROGRESS = '進行中';
    // タスク状況項目選択肢「レビュー待ち」
    private static final String STATUS_REVIEW = 'レビュー待ち';
    // タスク状況項目選択肢「完了」
    private static final String STATUS_COMPLETE = '完了';
    // タスク優先度項目選択肢「低」
    private static final String PRIORITY_LOW = '低';
    // タスク名検索用定数「レビュー依頼」
    private static final String REVIEW_REQUEST = 'レビュー依頼';
    
   /* 
    * タスク作成前処理
    * Trigger.isBefore && Trigger.isInsert時実行処理
    * @param: newTaskList 更新後タスクレコードリスト
    * @return: 無し
    */
    public void beforeInsertTask(List<Task__c> newTaskList){
        //状況自動更新処理
        setStatus(newTaskList);
    }
    
    /* 
    * タスク作成前処理
    * Trigger.isBefore && Trigger.isUpdate時実行処理
    * @param: newTaskList 更新後タスクレコードリスト
    * @return: 無し
    */
    public void beforeUpdateTask(List<Task__c> newTaskList){
        //状況自動更新処理
        setStatus(newTaskList);
    }
    
    /* 
     * タスク作成前処理
     * Trigger.isAfter && Trigger.isUpdate時実行処理
     * @param: newtaskList 更新後タスクレコードリスト
     * @param: oldTaskMap 更新前タスクMap
     * @return: 無し
     */
    public void afterUpdateTask(List<Task__c> newTaskList, Map<Id,Task__c> oldTaskMap){
        //タスク自動生成処理
        createTask(newTaskList);
        //タスク完了更新処理
        setCompleteStatus(newTaskList,oldTaskMap);
    }

    /*
     * 状況自動更新処理
     * @param: newTaskList 更新後タスクレコードリスト
     * @return: 無し
     */
    public static void setStatus(List<Task__c> newTaskList){
        
        for(Task__c task : newTaskList){

            if(task.Progress__c == 0){
                task.Status__c = STATUS_NOTYET;
            }else if(task.Progress__c < 80){
                task.Status__c = STATUS_PROGRESS;
            }else if(task.Progress__c < 100){
                task.Status__c = STATUS_REVIEW;
            }else if(task.Progress__c == 100){
                task.Status__c = STATUS_COMPLETE;
            }
        } 
    }
    
    /*
     * タスク自動生成処理
     * @param: newTaskList 更新後タスクレコードリスト
     * @return: 無し
     */
    public static void createTask(List<Task__c> newTaskList){
        
        Task__c insTask = new Task__c();
        Set<Id> taskId = new Set<Id>();
        List<Task__c> insTaskList = new List<Task__c>();
        
        for(Task__c task : newTaskList){
            taskId.add(task.Id);
        }
        
        //対象の子タスクの名前にレビュー依頼と入っているレコードを取得
        List<Task__c> childTaskList = [SELECT Id,Name 
                                         FROM Task__c 
                                        WHERE ParentTask__c = :taskId
                                          AND Name LIKE :('%' + REVIEW_REQUEST)];

        //タスク名にレビュー依頼と入っている子タスクが無いかチェック
        if(childTaskList.size() == 0){

            for(Task__c task : newTaskList){

                //対象の状況項目が「レビュー待ち」かチェック
                if(task.Status__c == STATUS_REVIEW && task.ParentTask__c == null){
                    insTask.Name = task.Name + REVIEW_REQUEST;
                    insTask.PlanStartDate__c = date.today();
                    insTask.PlanEndDate__c = date.today() + 7;
                    insTask.Status__c = STATUS_NOTYET;
                    insTask.Priority__c = PRIORITY_LOW;
                    insTask.Anken__c = task.Anken__c;
                    insTask.ParentTask__c = task.Id;
                    
                    insTaskList.add(insTask);
                }
            }

            //レコード作成数が0以上なら作成
            if(insTaskList.size() > 0){
                insert insTaskList;
            }
        }   
    }

    /*
     * タスク完了更新処理
     * @param: newTaskList 更新後タスクレコードリスト
     * @param: oldTaskMap 更新前タスクMap
     * @return: 無し
     */
    public static void setCompleteStatus(List<Task__c> newTaskList, Map<Id,Task__c> oldTaskMap){

        Task__c oldTask = new Task__c();
        Id buckupId = null;
        Set<Id> parentIds = new Set<Id>();
        Map<Id,Task__c> parentUpdateTaskMap = new Map<Id,Task__c>();
        Map<Id,Task__c> childUpdateTaskMap = new Map<Id,Task__c>();
        Map<Id,Integer> countMap = new Map<Id,Integer>();
        Map<Id,Integer> countTotalMap = new Map<Id,Integer>();
        List<Task__c> updateTaskList = new List<Task__c>();
        List<Task__c> parentTaskList = new List<Task__c>();
        List<Task__c> childTaskList = new List<Task__c>();
        Integer count = 0;
        Integer countTotal = 0;

        for(Task__c task : newTaskList){
            oldTask = new Task__c();
            oldTask = oldTaskMap.get(task.Id);

            //更新前と更新後の状況項目が変更済みかチェック
            if(task.Status__c != oldTask.Status__c && task.Status__c == STATUS_COMPLETE){

                if(task.ParentTask__c == null){
                    parentUpdateTaskMap.put(task.id,task);
                }else if(task.ParentTask__c != null){
                    childUpdateTaskMap.put(task.id,task);
                    parentIds.add(task.ParentTask__c);
                }
            }
        }

        //親タスク取得
        parentTaskList = [SELECT Id,Status__c FROM Task__c WHERE Id = :parentIds];

        if(!parentUpdateTaskMap.isEmpty() && parentUpdateTaskMap != null){
            //子タスク取得
            childTaskList = [SELECT Id,Status__c,ParentTask__c 
                               FROM Task__c 
                              WHERE ParentTask__c = :parentUpdateTaskMap.keySet()];

            for(Task__c childTask : childTaskList){
                
                if(childTask.Status__c != STATUS_COMPLETE){
                childTask.Status__c = STATUS_COMPLETE;
                childTask.Progress__c = 100;
                updateTaskList.add(childTask);
                }
            }
        }

        if(!childUpdateTaskMap.isEmpty() && childUpdateTaskMap != null){
            //子タスク取得
            childTaskList = [SELECT Id,Status__c,ParentTask__c
                               FROM Task__c
                              WHERE ParentTask__c = :parentIds
                                AND Id != :childUpdateTaskMap.keySet()
                           ORDER BY ParentTask__c,Id];
            
            for(Task__c childTask : childTaskList){
                
                //親タスクIDの判定用変数
                if(buckupId == null){
                    buckupId = childTask.ParentTask__c;
                }

                //今のレコードの親タスクが同じかチェック
                if(childTask.ParentTask__c == buckupId){
                    countTotal++;

                    //子タスクの状況項目が「完了」かチェック
                    if(childTask.Status__c == STATUS_COMPLETE){
                        count++;
                    }
                }else{
                    countMap.put(buckupId,count);
                    countTotalMap.put(buckupId,countTotal);

                    buckupId = childTask.ParentTask__c;
                    count = 0;
                    countTotal = 1;

                    //子タスクの状況項目が「完了」かチェック
                    if(childTask.Status__c == STATUS_COMPLETE){
                        count++;
                    }
                }
            }

            countMap.put(buckupId,count);
            countTotalMap.put(buckupId,countTotal);

            for(Task__c parentTask : parentTaskList){
                count = countMap.get(parentTask.id);
                countTotal = countTotalMap.get(parentTask.id);

                //子タスクの完了数と総数が同じかチェック
                if(count == countTotal){
                    parentTask.Status__c = STATUS_COMPLETE;
                    parentTask.Progress__c = 100;
                    updateTaskList.add(parentTask);
                }
            }
        }

        //レコード更新数が0以上なら更新
        if(updateTaskList.size() > 0){
            update updateTaskList;
        }
    }
}

    /*
     * トリガ学習テスト
     * @param: 無し
     * @return: 無し
     */
    /*public static void listTest(){
        List<String> listTest = new List<String>();
        Map<String,Integer> mapTest = new Map<String,Integer>();
        Set<String> setTest = new Set<String>();
        Map<Id,Task__c> taskMap = new Map<Id,Task__c>([SELECT id,name FROM Task__c]);

        //System.debug('taskMap' + taskMap);

        listTest.add('b');
        listTest.add('a');

        //System.debug('listTest' + listTest);

        mapTest.put('aa', 1);
        mapTest.put('bb', 2);
        mapTest.put('cc', 3);

        //System.debug('mapTest' + mapTest);

        setTest.add('a');
        setTest.add('b');
        setTest.add('c');
        setTest.add('a');

        //System.debug('settest' + settest);
    }*/