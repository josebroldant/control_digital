%1.Enter the characteristics equation with variable 's'
syms s
disp('enter characteristics equation')
chareq=input(':');
chars=coeffs(chareq,'all');%'chars' is used for storing coefficients of characteristics equation.
Nc=length(chars);         %'Nc' stores the number of coefficients in characteristics equation or the 1+(order of characteristics equation).
A=zeros;               %let a variable matrix like 'A' and assign it as zeros matrix.
%2.Input all the coefficient in two rows arrangement as follows:
         t=0;  %'t' is used for detecting missing coefficient in routh array. 
         s=0;  %'s' is used for detecting sign changes in coefficients of routh array.
         m=1;   
         l=1;
         j=1;
        while(l<=Nc)
          for i=1:2
          if(l<=Nc)
          in=chars(l);
          
            if(in==0)
              t=1;
              s=0;
            end
            
          if(l>=2&&t==0)
          m=(in/abs(in))*(A(1,1)/abs(A(1,1)));
          if(m<0)
              s=1;
          end
          end
          
          end
          if(l>Nc)
           in=0;
          end
          A(i,j)=in;
          l=l+1;
          end
           j=j+1;
        end 
         C=j-1;       %here C stores the number of collumns.  

%3.Now let's fill the rows with row number greater than two.
if(s==0&&t==0)
i=3;
cn=0; %it is used for counting the number of zeros in a single row.
spl=0; %it is used for indication of that a routh array contains the special case or not.
while(i<=Nc)

%4.if the case is not special then following condition will be followed.
m=1;
if(cn~=C)
   
cn=0;
j=1;
k=2;

while(j<=C)

if(j<=C-1)
A(i,j)=(A(i-1,1)*A(i-2,k)-A(i-2,1)*A(i-1,k))/(A(i-1,1));%formula or method according to routh array rule or method for calculating row elements of row number greater than  two.
end
if(j==C)                   %last collumn has to be filled with zero.
A(i,j)=0;
end

if(A(i,j)==0) %The process for counting number of zeros in a row.
cn=cn+1;
end

if(A(i,1)==0&&j==2&&cn==1)      %it is for the case when first collumn element is zero in a row. Then we have to substitute the zero with small quantity for not getting infinity.
A(i,1)=0.01;
end
if(j==1&&cn==0)
m=m*(A(i,j)/abs(A(i,j)));
end
j=j+1;
k=k+1;
end

end
%5.it is for the special case when all the elements of a row are zero.
if(cn==C)
spl=1;
cn=0;
%below is the process for getting coefficients of differentiation of the auxillary polynomial.
for h=1:C                  
pow=(Nc-(i-1)-2*(h-1));
if(pow>=0)
A(i,h)=A(i-1,h)*pow;
end
if(pow<0)
A(i,h)=0;
end
if(h==1&&cn==0)
m=m*(A(i,h)/abs(A(i,h)));
end
end
cur=i;
end 
i=i+1;
end
if(m<0)   %special case is aborted in sign change case.
spl=0;
end
%6.Now it's time for getting results from routh array.
Routh_array=A
polyn=0;
syms s
%if case is special then by following method we can get auxillary solution and we will get to know that system is marginally stable.
if(spl==1)
    for b=1:C
        pow=(Nc-(cur-1)-2*(b-1));
        if(pow>=0)
        polyn=polyn+A(cur-1,b)*s^pow;               %here auxillary polynomial is being generated.
        end
    end
        solutions=solve(polyn==0,s);                %solutions of auxillary equation.
    disp('system is marginally stable and hence')
    auxillary_solutions=solutions
end

%if case is not special then number of sign changes will be calculated and depending on that it is known that system is stable or not.
if(spl==0)
m=1;
con=0;
    for i=1:Nc
          m=m*(A(i,1)/(abs(A(i,1))));  %'m' has two values '1' and '-1' only and it is used for detecting number of sign changes in first collumn of routh array.
        
          if(m<0)
              con=con+1;
          end
          
            if(A(i,1)>0)
              m=1;
           end
    end
    if(con==0)
        disp('system is stable')
    end
    if(con>0)
        disp('system is unstable and has')
        number_of_poles_in_right_half_plane=con
    end
end
end
if(s==1)
    disp('characteristic equation is invalid for routh array formation as it contains coefficients of different signs.')
end
if(t==1)
    disp('characteristic equation is invalid for routh array formation as it has missing coefficient.')
end