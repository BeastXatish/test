({
	handleUploadFinished: function (component, event) {
        // Get the list of uploaded files
         var uploadedFiles = event.getParam("files");
        component.set("v.filevar",uploadedFiles.length);
    // alert("Files uploaded : " + uploadedFiles.length);
      //    uploadedFiles.forEach(file => console.log(file.name));   

        // Get the file name
        
    }, 
    
    handleClick: function(component,event){
          alert("File Uploaded"+component.get("v.filevar"));
       
        }
})