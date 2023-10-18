({
	myAction : function(component, event, helper) {
		component.set("v.Columns",[
            {label:"FirstName",fieldName:"FirstName",type:"text",editable: true},
            {label:"LastName",fieldName:"LastName",type:"text",editable: true},
            {label:"Phone",fieldName:"Phone",type:"phone",editable: true}
        ]);
     var action = component.get("c.getContacts");
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this,function(data){
            component.set("v.Contacts",data.getReturnValue());
        }); 
        $A.enqueueAction(action);
	},
    
        handleSaveEdition: function (component, event, helper) {
        var draftValues = event.getParam('draftValues');
        console.log(draftValues);
        var action = component.get("c.updateContact");
        action.setParams({"conList" : draftValues});
        action.setCallback(this, function(response) {
            var state = response.getState();
            $A.get('e.force:refreshView').fire();
            
        });
        $A.enqueueAction(action);
        
    }
})