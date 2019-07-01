Selecting teams that have at least one male and female player                                                     
                                                                                                                  
Three Solution (none were posted)                                                                                 
                                                                                                                  
    a. SQL having                                                                                                 
    b. DOW                                                                                                        
    c. SQL union                                                                                                  
                                                                                                                  
This why I use SAS as my base system, clarity, flexibility and spped.                                             
                                                                                                                  
github                                                                                                            
https://tinyurl.com/yylr4f6f                                                                                      
https://github.com/rogerjdeangelis/utl_selecting-teams-that-have-at-least-one-male-and-female-player              
                                                                                                                  
SAS Forum                                                                                                         
https://tinyurl.com/y6odyjz8                                                                                      
https://communities.sas.com/t5/SAS-Programming/Identifying-ids-with-two-values/m-p/570129                         
                                                                                                                  
*_                   _                                                                                            
(_)_ __  _ __  _   _| |_                                                                                          
| | '_ \| '_ \| | | | __|                                                                                         
| | | | | |_) | |_| | |_                                                                                          
|_|_| |_| .__/ \__,_|\__|                                                                                         
        |_|                                                                                                       
;                                                                                                                 
                                                                                                                  
data have;                                                                                                        
  input id$ sex$;                                                                                                 
cards4;                                                                                                           
Brazil F                                                                                                          
England F                                                                                                         
England  M                                                                                                        
England  M                                                                                                        
France M                                                                                                          
Spain F                                                                                                           
Spain M                                                                                                           
USA F                                                                                                             
USA M                                                                                                             
;;;;                                                                                                              
run;quit;                                                                                                         
                                                                                                                  
*            _               _                                                                                    
  ___  _   _| |_ _ __  _   _| |_                                                                                  
 / _ \| | | | __| '_ \| | | | __|                                                                                 
| (_) | |_| | |_| |_) | |_| | |_                                                                                  
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                 
                |_|                                                                                               
;                                                                                                                 
                                                                                                                  
WORK.WANT total obs=3                                                                                             
                                                                                                                  
   ID       | RULES                                                                                               
            |                                                                                                     
   England  | These are the teams with at least                                                                   
            | ome male and one female                                                                             
   Spain    |                                                                                                     
   USA      |                                                                                                     
                                                                                                                  
*          _       _   _                                                                                          
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                          
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|                                                                         
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                         
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                         
                                                                                                                  
  __ _      ___  __ _| | | |__   __ ___   _(_)_ __   __ _                                                         
 / _` |    / __|/ _` | | | '_ \ / _` \ \ / / | '_ \ / _` |                                                        
| (_| |_   \__ \ (_| | | | | | | (_| |\ V /| | | | | (_| |                                                        
 \__,_(_)  |___/\__, |_| |_| |_|\__,_| \_/ |_|_| |_|\__, |                                                        
                   |_|                              |___/                                                         
;                                                                                                                 
                                                                                                                  
proc sql;                                                                                                         
  select                                                                                                          
    id                                                                                                            
  from                                                                                                            
    have                                                                                                          
  group                                                                                                           
    by id                                                                                                         
  having                                                                                                          
    sum((sex="M")>0) and sum(sex="F")>0                                                                           
;quit;                                                                                                            
                                                                                                                  
*_             _                                                                                                  
| |__       __| | _____      __                                                                                   
| '_ \     / _` |/ _ \ \ /\ / /                                                                                   
| |_) |   | (_| | (_) \ V  V /                                                                                    
|_.__(_)   \__,_|\___/ \_/\_/                                                                                     
                                                                                                                  
;                                                                                                                 
                                                                                                                  
                                                                                                                  
data want;                                                                                                        
                                                                                                                  
  do _n_=1 by 1 until (last.id);                                                                                  
     set have;                                                                                                    
     by id;                                                                                                       
     if sex="M" then flg_a=1;                                                                                     
     if sex="F" then flg_b=1;                                                                                     
  end;                                                                                                            
  if flg_a and flg_b then output;                                                                                 
  keep id;                                                                                                        
run;quit;                                                                                                         
                                                                                                                  
*                   _               _                                                                             
  ___     ___  __ _| |  _   _ _ __ (_) ___  _ __                                                                  
 / __|   / __|/ _` | | | | | | '_ \| |/ _ \| '_ \                                                                 
| (__ _  \__ \ (_| | | | |_| | | | | | (_) | | | |                                                                
 \___(_) |___/\__, |_|  \__,_|_| |_|_|\___/|_| |_|                                                                
                 |_|                                                                                              
;                                                                                                                 
                                                                                                                  
proc sql;                                                                                                         
  select                                                                                                          
     id                                                                                                           
  from (                                                                                                          
     select                                                                                                       
        id                                                                                                        
       ,sex                                                                                                       
     from                                                                                                         
        have                                                                                                      
     union                                                                                                        
     select                                                                                                       
        id                                                                                                        
       ,sex                                                                                                       
     from                                                                                                         
        have                                                                                                      
  )                                                                                                               
  group                                                                                                           
     by id                                                                                                        
  having                                                                                                          
     count(id)=2                                                                                                  
;quit;                                                                                                            
                                                                                                                  
                                                                                                                  
                                                                                                                  
