trigger LeadTrigger on Lead (before insert, before update, after insert, after update) {
       
    if(Trigger.isBefore){                           
        if(Trigger.isInsert){           
        }else if(Trigger.isUpdate){          
        }            
    }else if(Trigger.isAfter){            
        if(Trigger.isInsert){                           
        }else if(Trigger.isUpdate){
              // trigger aciona apos registro atualizar
              // Objeto chama metodo estatico criaConta
              LeadBO.criaConta(Trigger.new); 
        }        
    }
}