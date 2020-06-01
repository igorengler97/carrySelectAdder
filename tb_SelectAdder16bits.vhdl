--*===============*=================*--
-- Test Bench Somador Completo para 16 bits
-- OAC 
-- 09/09/2106
-- Utiliza RippleyCarryAdder_16bits.vhdl
-- Portas lógicas com latência de 4ns
--*===============*=================*--

library ieee;
use ieee.std_logic_1164.all;

entity tb_SelectAdder16bits is

end tb_SelectAdder16bits;

architecture comportamento of tb_SelectAdder16bits is

   component SelectAdder16bits is
      port(
         X, Y : in  std_logic_vector(15 downto 0); -- X + Y
         T    : in  std_logic;                     -- Transp. de entrada
         C    : out std_logic;                     -- Transp. de saída
         S    : out std_logic_vector(15 downto 0)  -- S = X + Y
      );
   end component;

   signal X, Y : std_logic_vector(15 downto 0);
   signal T, C : std_logic;
   signal S    : std_logic_vector(15 downto 0);

begin

   -- mapeamento
   u_ca: SelectAdder16bits
   port map(X, Y, T, C, S);

   process
   begin

   -- melhor caso
   X <= x"0001"; -- 8 bits zeros
   Y <= x"0000";
   T <= '0'; -- sem transporte de entrada

   -- estabiliza em 16 ns
   wait for 150 ns;

   -- pior caso
   X <= x"FFFF"; -- 8 bits 1's
   Y <= x"0001";
      -- causa carry-out em todos os bits

   -- estabiliza em 128 ns
   wait for 150 ns;

   wait;
   end process;

end architecture;
