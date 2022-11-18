public class LeadBO {
    
    // metodo para criar nova conta onde recebe como argmento uma lista de lead
	public static void criaConta (list<Lead> LeadTrigger){  
    
        // cria uma lista de contas
		list<Account> novaConta = new list<Account>();
        
        	// itera na lista de Lead passada como argumento no metodo criaConta
			for(Lead itemLead : LeadTrigger)
            {
                // variavel do tipo Lead que recebe o o objeto Trigger.oldMap para recuperar IDs dos registros
                // antigos dos sObject.
                Lead leadOld = (Lead) Trigger.oldMap.get(itemLead.Id);
                
                // Se o leadOld for atualizado para Novo, seu Status para Contactado e seu CNPJ não estiver em vazio...
				if(leadOld.Status == 'Novo' && itemLead.Status == 'Contactado' && itemLead.CNPJ__c != null)
                {
                    //... cria uma nova conta, adcionando na Lista novaconta criada no inicio 
					novaConta.add(new Account(Name = itemLead.Company,
                                 			  Rating = 'Hot',
                                              Description = 'Conta criada a partir do Lead '+ itemLead.Id,
								              CNPJ__c = itemLead.CNPJ__c));
				}
                
			}
        
        	// se novaConta não for vazio então insira a nova conta criada
	        if(!novaConta.isEmpty())
            {
	            insert novaConta;
	        }		    
	}
}