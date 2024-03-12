public class CaseApexClass {
 // Acccount with Case Record Insert
 // Method- function call


       Public void AccountCre(){
        Account Acc = New Account();
        Acc.Name = 'Durga';
        Insert Acc;

           CaseCre(Acc.Id);
    } 
    
    Public void CaseCre(id Accidvar){
        Case Ca = New Case();
        Ca.status = 'new';
        ca.origin = 'phone';
        ca.Subject = 'TestCase';
        insert Ca;

    }
}