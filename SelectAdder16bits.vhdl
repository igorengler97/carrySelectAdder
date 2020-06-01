--------------------------------------------
-- Somador Completo para 16 bits
-- 20/09/2019 
-- Organização e Arquitetura de Computadores 
-- Select Carry Adder
-- Portas lógicas com latência de 4ns 
-- Max 4 input
-- Vitor Gilnek, Igor Engler, Bruno Dierich
--------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity SelectAdder16bits is
   generic (DELAY: time := 4.0 ns);
   port(
      X, Y : in  std_logic_vector(15 downto 0); -- X + Y
      T    : in  std_logic;                     -- Transporte de entrada
      C    : out std_logic;                     -- Transporte de saída
      S    : out std_logic_vector(15 downto 0)  -- S = X + Y
   );
end SelectAdder16bits;


architecture comportamento of SelectAdder16bits is

   component SelectAdder08bits is
   port(
      X, Y : in  std_logic_vector(7 downto 0); 	-- X + Y
      T    : in  std_logic;                     -- Transporte de entrada
      C    : out std_logic;                     -- Transporte de saída
      S    : out std_logic_vector(7 downto 0)  	-- S = X + Y
   );
   end component;

   -- vetor de carry
   signal cv1 : std_logic;
   signal C1  : std_logic;
   signal C2  : std_logic;
   signal cv0 : std_logic;
   signal S1 : std_logic_vector(7 downto 0);
   signal S2 : std_logic_vector(7 downto 0);
 

begin
   
   C<= C1 when cv1 = '0' else C2 after DELAY*2;
   S(15 downto 8)<=S1 when cv1='0' else S2 after DELAY*2;	
	
   u_ca0 : SelectAdder08bits 
   port map(X(7 downto 0), Y(7 downto 0), T , cv1, S(7 downto 0));

   u_ca1 : SelectAdder08bits
   port map(X(15 downto 8), Y(15 downto 8), '0' , C1, S1);

   u_ca2 : SelectAdder08bits
   port map(X(15 downto 8), Y(15 downto 8), '1' , C2, S2);


end architecture;
