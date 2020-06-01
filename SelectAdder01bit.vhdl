--*===============*=================*--
-- Somador Completo para 01 bit
-- OAC 
-- 09/09/2019
-- Rippley Carry Adder
-- Portas lógicas com latência de 4ns 
-- Max 4 input
--*===============*=================*--

library ieee;
use ieee.std_logic_1164.all;

entity SelectAdder01bit is
   generic (DELAY: time := 4.0 ns);
   port(
      X, Y : in  std_logic; -- X + Y
      T    : in  std_logic; -- Transporte de entrada
      C    : out std_logic; -- Transporte de saída
      S    : out std_logic  -- S = X + Y
   );
end SelectAdder01bit;

architecture comportamento of SelectAdder01bit is

begin
   -- XOR de duas entradas
   S <= ((X xor Y) xor T) after 2*DELAY;

   -- ANDs em paralelo, em série com OR
   C <= (X and T) or ((Y and T) or (X and Y)) after 2*DELAY;
end architecture;
