public class EmployeDeatils {
    
    
    Public static void SetEmployeDeatils(){
        
        EmployeWrapper Emp1 = new EmployeWrapper();
        emp1.empEmail = 'Test.Gmail.com';
        emp1.empID = '1234';
        emp1.empname = 'Sanju';
             
        AddressWrapperclass AddWrap = new AddressWrapperclass();
        AddWrap.city = 'hyderbad'; 
        AddWrap.Country = 'India';
        
        emp1.adrw = AddWrap;
        
        
        System.debug('Empolyee data' + emp1);
    
        
    }
}