({
    handleRefresh : function(component,event,helper) {

        var refreshEvent = $A.get("e.force:refreshView");
if (refreshEvent) {
refreshEvent.fire();
}

    }
})