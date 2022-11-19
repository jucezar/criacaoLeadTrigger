# 	:crossed_swords: Processo de Criação de Triggers

Este case abaixo é um pequeno trecho do mini projeto que realizamos para um cliente real. Ele realiza a criação de uma conta quando um *Lead* for contactado. 

## Case:

> Processo de captura do Lead é através das seguintes estapas: Novo, Contactado, Convertido e Perdido. Ao **alterar** o status de Novo para Contactado, uma conta deverá
ser criada ou atualizada com o nome da empresa e CNPJ do Lead gerado, caso o CNPJ estaja preenchido.

### :heavy_check_mark: Criando uma Classe LeadBO

A classe BO encapsula a lógica de negócios de um sObject onde é implementada em um método *estático* de uma classe. Esta será chamada na trigger.
Definição:  BO - Bussiness Object


~~~
public class LeadBO {
    
	public static void criaConta (list<Lead> LeadTrigger){
           ...
   }
 
 } 
~~~

Como precisamos recuperar os registros antigos od IDs antigos para atualizá-los, criamos uma variável para armezanar o objeto **trigger.oldMap** do tipo *Lead*.

~~~
 Lead leadOld = (Lead) Trigger.oldMap.get(itemLead.Id);
~~~

Para não estourar a qtde de DML permitidas, é importante criar uma lista do tipo do objeto que queremos criar para adicionarmos nela. Criamos a lista fora da iteração(for)
para não haver conflito.

~~~
novaConta.add(new Account(Name = itemLead.Company,
                          Rating = 'Hot',
                          Description = 'Conta criada a partir do Lead '+ itemLead.Id,
								          CNPJ__c = itemLead.CNPJ__c));
~~~

### :heavy_check_mark: Criando uma Classe LeadTrigger

 Na definição da trigger, já começamos inserindo todas os tempos: *before insert, before update, after insert, after update*. 
 
 ~~~
 trigger LeadTrigger on Lead (before insert, before update, after insert, after update) {...
 ~~~
 
 E através disto definimos o escopo de acordo com um padrão bastante conhecido, aplicando a classe com o método estático ao tempo que foi estabelecido.
 
 ~~~
 if(Trigger.isBefore)
 {                           
     if(Trigger.isInsert)
     {
     
     } 
     else if(Trigger.isUpdate) 
     {
     
     }            
  } 
    else if(Trigger.isAfter)
  {            
        if(Trigger.isInsert)
        {
        
        }
        else if(Trigger.isUpdate)
        {
          LeadBO.criaConta(Trigger.new); 
        }        
    }
 ~~~
 
 ### :heavy_check_mark: Criando uma Classe LeadTriggerTest
 
 A classe **LeadTriggertest** tem por objetivo testar se o está sendo criado com os requisitos mínimos obrigatórios e também se ela não realiza a 
 ação caso este requisito não seja seguido.
 Se faz necessário utilizar a anotation **@IsTest**, palavra reservada do Apex, para realização dos teste automatizados, tanto no início da classe quanto na definição
 dos método.
 
 ~~~
 @isTest
public class LeadTriggerTest {
	
    @isTest 
    public static void criarContaTest(){
    
~~~

Durante, por exemplo, o teste ```teste positivo``` se faz necessário a utilização de algumas funções DML para inserção ou atualização do objeto em questão(Lead)
e para verificar se o objeto realmente foi criado com sucesso efetuar uma busca com a query(SOQL) analisando a existência do *sObject* criado.

~~~
        Lead novoLead	  = new Lead();    // cria um novo Lead       	
        novoLead.lastName = 'TesteName';	
        novoLead.Company  = 'Teste Company';
        novoLead.Status   = 'Novo';
		    novoLead.CNPJ__c  = '10440482000154';        	
        insert novoLead;     // insere o Lead criado - acao DML
          
        Test.startTest();
        novoLead.Status  = 'Contactado';	
        update novoLead; // atualiza seu status
           
        List<Account> lstConta = [Select Id From Account WHERE Id =: novoLead.Id]; // varre os objetos existentes procurando com o mesmo Id do objeto Lead criado
        system.debug ('lstConta' + lstConta);
        system.assert(lstConta.size()>0, 'Foi criada a Conta'); // caso encontre mostra mensagem
        Test.stopTest();
~~~

Caso queiram conhecer mais sobre Teste o assunto de maneira teórica clique [aqui](https://trailhead.salesforce.com/pt-BR/content/learn/modules/apex_testing)

![https://img.shields.io/badge/Salesforce-00A1E0?style=for-the-badge&logo=Salesforce&logoColor=white](https://img.shields.io/badge/Salesforce-00A1E0?style=for-the-badge&logo=Salesforce&logoColor=white)
