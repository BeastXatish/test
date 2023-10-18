public with sharing class todocontrollers {
    
    @AuraEnabled
    public static String addTodo(String payload){
     ToDo payloadObject = (ToDo) JSON.deserialize(payload, ToDo.Class);
     SObject tsk = (SObject) Type.forName('ToDo__c').newInstance();
     tsk.put('Name', payloadObject.todoName);
     tsk.put('Done__c', payloadObject.done);
        
     insert tsk;

     return String.valueof(tsk.Id);
    }

    @AuraEnabled()
    public static void updateTodo(String payload){
     Todo payloadObject = (ToDo) JSON.deserialize(payload, ToDo.Class);

     SObject tsk = (SObject) Type.forName('ToDo__c').newInstance();
     tsk.put('ID', payloadObject.todoId);
     tsk.put('Name', payloadObject.todoName);
     tsk.put('Done', payloadObject.done);
        
     update tsk;
    }

    @AuraEnabled()
    public static void deleteTodo(String todoId){
    
     SObject tsk = (SObject) Type.forName('ToDo__c').newInstance();
     tsk.put('ID', todoId);
        
     delete tsk;
    }

    @AuraEnabled(cacheable = true)
    public static List<ToDo> getAllTodos(){
     List<SObject> tsks = Database.query(
        'SELECT Id, Name, CreatedDate , Done__c FROM ToDo__c WHERE CreatedDate = LAST_N_DAYS:7 ORDER BY CreatedDate DESC'
     );
     return getToDos(tsks);
    }

    @AuraEnabled
    public static List<ToDo> getCurrentTodos(){
     List<SObject> tsks = Database.query(
        'SELECT Id, Name, CreatedDate , Done__c FROM ToDo__c WHERE CreatedDate = TODAY ORDER BY CreatedDate DESC'
     );
     return getToDos(tsks);
    }
    @AuraEnabled
    public static List<ToDo> getToDos(List<SObject> tsks){
     List<ToDo> todos = new List<ToDO>();
     for(SObject tsk: tsks){
        ToDo todo = new ToDo();
        todo.todoId = tsk.Id;
        todo.todoName = String.valueof(tsk.get('Name'));
        todo.todoDate = Date.valueof(tsk.get('CreatedDate'));
        todo.done = Boolean.valueof(tsk.get('Done__c'));
        todos.add(todo);
     }
     return todos;
    }

    class ToDo{
        @AuraEnabled
       public String todoId;
       @AuraEnabled
       public String todoName;
       @AuraEnabled
       public Date todoDate;
       @AuraEnabled
       public Boolean done;
    }
}