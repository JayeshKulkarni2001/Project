package com.rev;



import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class revTest {
    
    @BeforeEach
    public void started() {
        System.out.println("Test Started!");
    }
    
   
    @Test
    public void testLogin() {
        System.out.println("Verify Text Matches");
        assertEquals("REVSHOP","REVSHOP");
        
    }  
    
    @Test
    public void testLogin2() {
        
        boolean value = false;
        assertFalse(value);
        System.out.println("Verified Boolean Value");
        
    }  

    @AfterEach
    public void ended() {
       System.out.println("Test End!");
    }
}
