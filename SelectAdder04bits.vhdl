--*===============*=================*--
-- Somador Completo para 16 bits
-- OAC 
-- 09/09/2019
-- Utiliza RippleyCarryAdder_01bit_.vhdl
-- Portas lógicas com latência de 4ns
--*===============*=================*--

library ieee;
use ieee.std_logic_1164.all;

entity SelectAdder04bits is
   port(
      X, Y : in  std_logic_vector(3 downto 0); -- X + Y
      T    : in  std_logic;                     -- Transporte de entrada
      C    : out std_logic;                     -- Transporte de saída
      S    : out std_logic_vector(3 downto 0)  -- S = X + Y
   );
end SelectAdder04bits;


architecture comportamento of SelectAdder04bits is

   component SelectAdder01bit is
      generic (DELAY: time := 4.0 ns);
      port(
         X, Y : in  std_logic; -- X + Y
         T    : in  std_logic; -- Transporte de entrada
         C    : out std_logic; -- Transporte de saída
         S    : out std_logic  -- S = X + Y
      );
   end component;

   -- vetor de carry
   signal cv : std_logic_vector(2 downto 0);

begin

   u_ca0 : SelectAdder01bit 
   port map(X(0), Y(0), T    , cv(0), S(0));

   u_ca1 : SelectAdder01bit 
   port map(X(1), Y(1), cv(0), cv(1), S(1));

   u_ca2 : SelectAdder01bit 
   port map(X(2), Y(2), cv(1), cv(2), S(2));

   u_ca3 : SelectAdder01bit 
   port map(X(3), Y(3), cv(2), C    , S(3));

end architecture;
