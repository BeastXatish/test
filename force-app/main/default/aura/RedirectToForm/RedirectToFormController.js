({
    navigateToMyComponent : function(component, event, helper) {
        var event = $A.get("e.force:navigateToComponent");
        event.setParams({
            componentDef : "c:FirstAuraForm"
        });
        event.fire();
    }
})