public class ThinkAboutAuraClass {
Public string Name;
    
    //Constructor
    public  ThinkAboutAuraClass() {
      Name = 'sanju';
    }
    //Method  1 // Controller
    Public static void method1(){
         string FirstName = 'durga';
        method2('sanju');
           }
    //Method 2 // Helper
     Public static void method2(string Name){
         string FirstName = 'durga';
         method1();
    }
}