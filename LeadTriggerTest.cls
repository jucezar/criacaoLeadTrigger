@isTest
public class LeadTriggerTest {
	
    @isTest 
    public static void criarContaTest(){
			
		Lead novoLead	  = new Lead();           	
        novoLead.lastName = 'TesteName';	
        novoLead.Company  = 'Teste Company';
        novoLead.Status   = 'Novo';
		novoLead.CNPJ__c  = '10440482000154';        	
        insert novoLead;
          
        Test.startTest();
        novoLead.Status  = 'Contactado';	
        update novoLead;
           
        List<Account> lstConta = [Select Id From Account WHERE Id =: novoLead.Id];
        system.debug ('lstConta' + lstConta);
        system.assert(lstConta.size()>0, 'Foi criada a Conta');
        Test.stopTest();
    }
    
    @isTest 
    public static void criarContaTestN(){
			
		   Lead novoLead	 = new Lead();           	
           novoLead.lastName = 'TesteName';	
           novoLead.Company  = 'Teste Company';
           novoLead.Status   = 'Contactado';
           novoLead.CNPJ__c  = '10440482000154';	
           insert novoLead;
          
           Test.startTest();
           novoLead.Status  = 'Novo';	
           update novoLead;
           
           List<Account> lstConta = [Select Id From Account WHERE Id =: novoLead.Id];
           system.debug ('lstConta' + lstConta);
           system.assert(lstConta.size()>0, 'Não foi criada a Conta');
           Test.stopTest();
    }
    
    @isTest 
    public static void criarContaTestN1(){
			
		   Lead novoLead	 = new Lead();           	
           novoLead.lastName   	 = 'TesteName';	
           novoLead.Company  = 'Teste Company';
           novoLead.Status   = 'Novo';
           novoLead.CNPJ__c  = '10440482000154'; 
           insert novoLead;
          
           Test.startTest();
           novoLead.Status  = 'Perdido';	
           update novoLead;
           
           List<Account> lstConta = [Select Id From Account WHERE Id =: novoLead.Id];
           system.debug ('lstConta' + lstConta);
           system.assert(lstConta.size()>0, 'Não foi criada a Conta');
           Test.stopTest();
    }
    
    @isTest 
    public static void criarContaTestN2(){
			
		   Lead novoLead	 = new Lead();           	
           novoLead.lastName   	 = 'TesteName';	
           novoLead.Company  = 'Teste Company';
           novoLead.Status   = 'Novo';
           novoLead.CNPJ__c  = '10440482000154'; 
           insert novoLead;
          
           Test.startTest();
           novoLead.Status  = 'Convertido';	
           update novoLead;
           
           List<Account> lstConta = [Select Id From Account WHERE Id =: novoLead.Id];
           system.debug ('lstConta' + lstConta);
           system.assert(lstConta.size()>0, 'Não foi criada a Conta');
           Test.stopTest();
    }
}