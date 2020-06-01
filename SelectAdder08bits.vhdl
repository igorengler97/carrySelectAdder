--------------------------------------------
-- Somador Completo para 08 bits
-- 20/09/2019 
-- Organização e Arquitetura de Computadores 
-- Select Carry Adder
-- Portas lógicas com latência de 4ns 
-- Max 4 input
-- Vitor Gilnek, Igor Engler, Bruno Dierich
--------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity SelectAdder08bits is
   generic (DELAY: time := 4.0 ns);
   port(
      X, Y : in  std_logic_vector(7 downto 0); -- X + Y
      T    : in  std_logic;                    -- Transporte de entrada
      C    : out std_logic;                    -- Transporte de saída
      S    : out std_logic_vector(7 downto 0)  -- S = X + Y
   );
end SelectAdder08bits;


architecture comportamento of SelectAdder08bits is

   component SelectAdder04bits is
      port(
         X, Y : in  std_logic_vector(3 downto 0); -- X + Y
         T    : in  std_logic;                    -- Transporte de entrada
         C    : out std_logic;                    -- Transporte de saída
         S    : out std_logic_vector(3 downto 0)  -- S = X + Y
      );
   end component;

   -- vetor de carry
   signal cv1 : std_logic;
   signal C1  : std_logic;
   signal C2  : std_logic;
   signal cv0 : std_logic;
   signal S1 : std_logic_vector(3 downto 0);
   signal S2 : std_logic_vector(3 downto 0);
 

begin
   
   C<= C1 when cv1 = '0' else C2 after DELAY*2;
   S(7 downto 4)<=S1 when cv1='0' else S2 after DELAY*2;	
	
   u_ca0 : SelectAdder04bits 
   port map(X(3 downto 0), Y(3 downto 0), T , cv1, S(3 downto 0));

   u_ca1 : SelectAdder04bits
   port map(X(7 downto 4), Y(7 downto 4), '0' , C1, S1);

   u_ca2 : SelectAdder04bits
   port map(X(7 downto 4), Y(7 downto 4), '1' , C2, S2);


end architecture;
