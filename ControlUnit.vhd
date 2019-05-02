Library ieee; 
Use ieee.std_logic_1164.all;

Entity CU is 
  port( clk: in std_logic;
        opCode : in std_logic_vector(4 downto 0); 
	resetSignalin : in std_logic;
        resetSignal : out std_logic;
        Mux_PcP1_Call_Jump: out std_logic;
        Mux_Mux1_Mem: out std_logic;
        Mux_MemAdressValue: out std_logic_vector (1 downto 0);
        Mem_Write1_1address: out std_logic;
        Mem_write2_2addresses: out std_logic;
        Mem_Read: out std_logic;
        Mem_Read2: out std_logic; 
        Mux_MemData: out std_logic_vector(1 downto 0);
        Reg_File_Read: out std_logic;
        Multiply_Sig: out std_logic;
        Stack_Write: out std_logic;
        Mux_Stack: out std_logic_vector(1 downto 0);
        ALU_OP: out std_logic_vector(4 downto 0);
        Flag_Write: out std_logic;
        Jump_Signal: out std_logic;
        Call_Sig: out std_logic;
        WB_DeMux: out std_logic;
        WB_Mux: out std_logic_vector(1 downto 0);
        WB_Sig: out std_logic); 
end CU;

Architecture a_CU of CU is
    begin
        process(clk,resetSignalin) 
        begin
            if opCode = "00000" then  --Nop
                resetSignal <= '1';
                Mux_PcP1_Call_Jump <= '0'; 
                Mux_Mux1_Mem <= '0';
                Mux_MemAdressValue <= "00";
                Mem_Write1_1address <= '0';
                Mem_write2_2addresses <= '0';
                Mem_Read <= '0';
                Mem_Read2 <= '0';
                Mux_MemData <= "00";
                Reg_File_Read <= '0'; 
                Multiply_Sig <= '0';
                Stack_Write <= '0';
                Mux_Stack <= "00";
                ALU_OP <= "00000";
                Flag_Write <= '0';
                Jump_Signal <= '0';
                Call_Sig <= '0';
                WB_DeMux <= '0';
                WB_Mux <= "00";
                WB_Sig <= '0';

            elsif  opCode = "00001" then --SETC
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '0'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "00001";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '0';

            elsif opCode = "00010" then --ClrC
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '0'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "00010";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '0';

            elsif opCode = "00011" then --Not
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "00011";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "10" ;
            WB_Sig <= '1';

            elsif opCode = "00100" then  --INC
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "00100";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "10";
            WB_Sig <= '1';

            elsif opCode = "00101" then --dec
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "00101";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "10";
            WB_Sig <= '1';
            
            elsif opCode = "00110" then --out
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "00110";
            Flag_Write <= '0';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '1';
            WB_Mux <= "00";
            WB_Sig <= '0';

            elsif opCode = "00111" then --in
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '0'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "00111";
            Flag_Write <= '0';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "11";
            WB_Sig <= '1';

            elsif opCode = "01000" then --mov
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "01000";
            Flag_Write <= '0';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "10";
            WB_Sig <= '1';

            elsif opCode = "01001" then --ADD
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "01001";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "10";
            WB_Sig <= '1';

            elsif opCode = "01010" then --MUL
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '1';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "01010";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "10";
            WB_Sig <= '1';

            elsif opCode = "01011" then --Sub
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "01011";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "10";
            WB_Sig <= '1';

            elsif opCode = "01100" then --ANd
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "01100";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "10";
            WB_Sig <= '1';

            elsif opCode = "01101" then --OR
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "01101";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "10";
            WB_Sig <= '1';

            elsif opCode = "01110" then --SHL
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "01110";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "10";
            WB_Sig <= '1';

            elsif opCode = "01111" then --SHR
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "01111";
            Flag_Write <= '1';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "10";
            WB_Sig <= '1';
            

	    elsif opCode = "10000" then --PUSH
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "01";
            Mem_Write1_1address <= '1';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '1';
            Mux_Stack <= "00";
            ALU_OP <= "10000";
            Flag_Write <= '0';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '0';
           

	    elsif opCode = "10001" then --POP
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "01";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '1';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '1';
            Mux_Stack <= "10";
            ALU_OP <= "10001";
            Flag_Write <= '0';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '1';
            

	    elsif opCode = "10010" then --LDM
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "10010";
            Flag_Write <= '0';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "01";
            WB_Sig <= '1';
            


	    elsif opCode = "10011" then --LDD
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "10";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '1';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "10011";
            Flag_Write <= '0';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '1';
            

	    elsif opCode = "10100" then --STD
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "10";
            Mem_Write1_1address <= '1';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "10100";
            Flag_Write <= '0';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '0';
            

 	    elsif opCode = "10101" then --jz
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "10101";
            Flag_Write <= '0';
            Jump_Signal <= '1';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '0';
            

 	    elsif opCode = "10110" then --jn
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "10110";
            Flag_Write <= '0';
            Jump_Signal <= '1';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '0';
            

	    elsif opCode = "10111" then --jc
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "10111";
            Flag_Write <= '0';
            Jump_Signal <= '1';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '0';
            

	    elsif opCode = "11000" then --j
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '0';
            Mem_write2_2addresses <= '0';
            Mem_Read <= '0';
            Mem_Read2 <= '0';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '0';
            Mux_Stack <= "00";
            ALU_OP <= "11000";
            Flag_Write <= '0';
            Jump_Signal <= '1';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '0';
           

	   elsif opCode = "11001" then --call
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '0'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "00";
            Mem_Write1_1address <= '1';   --check ma3 khaled el etnein write wala wa7da ba ely be 1
            Mem_write2_2addresses <= '1';
            Mem_Read <= '1';
            Mem_Read2 <= '0';
            Mux_MemData <= "10";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '1';
            Mux_Stack <= "01";
            ALU_OP <= "11001";
            Flag_Write <= '0';
            Jump_Signal <= '0';
            Call_Sig <= '1';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '0';
            

	    elsif opCode = "11010" then --ret
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '1'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "10";
            Mem_Write1_1address <= '0';   
            Mem_write2_2addresses <= '0';
            Mem_Read <= '1';
            Mem_Read2 <= '1';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '1';
            Mux_Stack <= "11";
            ALU_OP <= "11010";
            Flag_Write <= '0';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '0';
            

	    elsif opCode = "11011" then --rti TODO
            resetSignal <= '0';
            Mux_PcP1_Call_Jump <= '1'; 
            Mux_Mux1_Mem <= '0';
            Mux_MemAdressValue <= "10";
            Mem_Write1_1address <= '0';   
            Mem_write2_2addresses <= '0';
            Mem_Read <= '1';
            Mem_Read2 <= '1';
            Mux_MemData <= "00";
            Reg_File_Read <= '1'; 
            Multiply_Sig <= '0';
            Stack_Write <= '1';
            Mux_Stack <= "11";
            ALU_OP <= "11010";
            Flag_Write <= '0';
            Jump_Signal <= '0';
            Call_Sig <= '0';
            WB_DeMux <= '0';
            WB_Mux <= "00";
            WB_Sig <= '0';
            end if;

        end process;
end a_CU;
