public with sharing class ActionFunctionVerificationController {
    
    public Account account {get; set;}
    
    public ActionFunctionVerificationController(ApexPages.StandardController stdController) {
        this.account = new Account();
    }
    
    public void doClick() {
        System.debug('doClick');
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, this.account.Name));
    }
}