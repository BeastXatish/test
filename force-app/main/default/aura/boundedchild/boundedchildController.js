({
	onchildvarchange : function(component, event, helper) {
		console.log("Child Value has been Changed");
        console.log("Old Value: " +event.getParam("oldvalue"));
        console.log("New Value: " +event.getParam("value"));
	},
    updatechildvariable : function(component, event, helper) {
		component.set("v.childvar","Child value has been updated upon button click")
	}
})