`timescale 1ns/100ps

class Numeros;
	randc logic [7:0] valorA;
	randc logic [7:0] valorB;
	constraint pares {valorA[0] == 1'b0 && valorB[0] == 1'b0;}
	constraint impares {valorA[0] == 1'b1 && valorB[0] == 1'b1;}
	constraint Apar_Bimpar {valorA[0] == 1'b0 && valorB[0] == 1'b1;}
	constraint Aimpar_Bpar {valorA[0] == 1'b1 && valorB[0] == 1'b0;}
endclass

//------------------------------------------------------------------------------------------------------------
//---------------------------------------- INTERFAZ Y CLOCKING BLOCKS ----------------------------------------
//------------------------------------------------------------------------------------------------------------

interface test_if #(parameter tamanyo=8) (input logic clk,rst_n);
   logic START;
   logic [tamanyo-1:0] NUM,DEN;
   logic [tamanyo-1:0] COC,RES;
   logic DONE;

   clocking md @(posedge clk);
	input #1ns START;
	input #1ns NUM,DEN;
	input #1ns COC,RES;
	input #1ns DONE;
   endclocking:md;

   clocking sd @(posedge clk);
	output #2ns START;
	output #2ns NUM,DEN;
	input #2ns COC,RES;
	input #2ns DONE;    
   endclocking:sd;

modport monitor (clocking md);

modport test (clocking sd);

modport duv (  
		input clk,
		input rst_n,
		input START,
		input NUM,DEN,
		output COC,RES,
		output DONE);   
endinterface

//-----------------------------------------------------------------------------------------
//---------------------------------------- PROGRAM ----------------------------------------
//-----------------------------------------------------------------------------------------

program estimulos #(parameter tamanyo=8)
(test_if.monitor monitorizar, test_if.test testear);

logic [tamanyo-1:0] CocGM, ResGM;

logic [tamanyo-1:0] targetCOC, targetRES;

logic [tamanyo-1:0] cola [$];


//------------ Cobertura ------------
covergroup Valores;
	cp1: coverpoint monitorizar.md.NUM {bins binsNum[256] = {[0:255]} ;}
	cp2: coverpoint monitorizar.md.DEN {bins binsDen[256] = {[0:255]} ;}
	cp3: cross cp1, cp2;
endgroup;

Numeros numeros_rcsg;
Valores valores_cg;

//------------ Pruebas ------------
initial 
begin
	numeros_rcsg = new;
	valores_cg = new;

	monitor_input;
	monitor_output;
	testear.sd.START<=1'b0;

	repeat (3) @(testear.sd);


	DIVIDE();

	$stop();
end 

task DIVIDE();
begin
// -------- pares
	$display ("Empiezo la verificacion pares");	
	numeros_rcsg.pares.constraint_mode(1);
	numeros_rcsg.impares.constraint_mode(0);
	numeros_rcsg.Apar_Bimpar.constraint_mode(0);
	numeros_rcsg.Aimpar_Bpar.constraint_mode(0);

	while(valores_cg.cp3.get_coverage()<25) 
	begin	
	assert (numeros_rcsg.randomize()) else $fatal("randomizacion fallada");

	divi(numeros_rcsg.valorA,numeros_rcsg.valorB);
	@(testear.sd);

	valores_cg.sample();
	$display(valores_cg.cp3.get_coverage());
	end 

// -------- impares
	$display ("Empiezo verificacion impares");
	numeros_rcsg.pares.constraint_mode(0);
	numeros_rcsg.impares.constraint_mode(1);
	numeros_rcsg.Apar_Bimpar.constraint_mode(0);
	numeros_rcsg.Aimpar_Bpar.constraint_mode(0);

	while(valores_cg.cp3.get_coverage()<50)
	begin
	assert (numeros_rcsg.randomize()) else $fatal("randomizacion fallada");

	divi(numeros_rcsg.valorA,numeros_rcsg.valorB);
	@(testear.sd);

	valores_cg.sample();
	$display(valores_cg.cp3.get_coverage());
	end 

// -------- par_impar
	$display ("Empiezo verificacion par-impar");
	numeros_rcsg.pares.constraint_mode(0);
	numeros_rcsg.impares.constraint_mode(0);
	numeros_rcsg.Apar_Bimpar.constraint_mode(1);
	numeros_rcsg.Aimpar_Bpar.constraint_mode(0);

	while(valores_cg.cp3.get_coverage()<75)
	begin
	assert (numeros_rcsg.randomize()) else $fatal("randomizacion fallada");

	divi(numeros_rcsg.valorA,numeros_rcsg.valorB);
	@(testear.sd);	
 
	valores_cg.sample();
	$display(valores_cg.cp3.get_coverage());
	end

// -------- impar_par
	$display ("Empiezo verificacion impar-par"); 
	numeros_rcsg.pares.constraint_mode(0);
	numeros_rcsg.impares.constraint_mode(0);
	numeros_rcsg.Apar_Bimpar.constraint_mode(0);
	numeros_rcsg.Aimpar_Bpar.constraint_mode(1);

	while(valores_cg.cp3.get_coverage()<100)
	begin
	assert (numeros_rcsg.randomize()) else $fatal("randomizacion fallada");

	divi(numeros_rcsg.valorA,numeros_rcsg.valorB);
	@(testear.sd);

	valores_cg.sample();
	$display(valores_cg.cp3.get_coverage());
	end
end
endtask

task divi(input reg[31:0] n,d);  
begin
	repeat(1) @(testear.sd);
	testear.sd.NUM <= n;  
	testear.sd.DEN <= d;  
	repeat(1) @(testear.sd);
	testear.sd.START <= 1'b1;  
	repeat(1) @(testear.sd);
	testear.sd.START <= 1'b0;
	wait (testear.sd.DONE);
	repeat(1) @(testear.sd);
end
endtask

task monitor_input; 
fork
begin
   while(1)
   begin
    @(monitorizar.md);
	if (monitorizar.md.START==1'b1)
	   begin
	   CocGM = monitorizar.md.NUM/monitorizar.md.DEN;  
	   ResGM = monitorizar.md.NUM%monitorizar.md.DEN;  
	   cola = {ResGM,CocGM,cola};
	   end
   end
end
join_none
endtask

task monitor_output;
fork
    while(1)
      begin 
        @(monitorizar.md);
	if(monitorizar.md.DONE==1'b1)
	begin
        $display("Comprobacion del valor");
        targetCOC = cola.pop_back();
        targetRES = cola.pop_back();
        if (monitorizar.md.DEN!=8'd0) assert (monitorizar.md.COC==targetCOC && monitorizar.md.RES==targetRES) else $display ("operacion mal realizada");
	end
      end
 join_none
endtask

endprogram 

// ----------------------------------------------------------------------------------------
// ---------------------------------------- MODULE ----------------------------------------
//-----------------------------------------------------------------------------------------

module tb_divisor();

parameter tamanyo=8;
logic CLK, RSTa;


parameter T = 20;

//------------ instanciacion ------------

test_if mi_interfaz(.clk(CLK),.rst_n(RSTa));


estimulos #(.tamanyo(tamanyo)) progEstimulos (.monitorizar(mi_interfaz),.testear(mi_interfaz));

duv #(.tamanyo(tamanyo)) mi_duv(.datos (mi_interfaz));

//------------ Reloj ------------
always
begin 
	#(T/2) CLK =  ~CLK;  
end

//------------ Initial ------------
initial
begin
	CLK = 1'b0;
	RSTa = 1'b1;
	reset();
end

//------------ Tareas reset ------------
task reset();
begin
	@(negedge CLK);
	RSTa = 1'b0;
	@(negedge CLK);
	RSTa = 1'b1;
end
endtask


endmodule 


module duv #(parameter tamanyo=8)(test_if.duv datos);


// Divisor_Algoritmico #(.tamanyo(tamanyo)) duv1 (.CLK(datos.clk), .RSTa(datos.rst_n), .Start(datos.START), .Num(datos.NUM), .Den(datos.DEN), .Coc(datos.COC), .Res(datos.RES), .Done(datos.DONE));
divisor_segmentado #(.tamanyo(tamanyo)) duv1 (.CLK(datos.clk), .RSTa(datos.rst_n), .START(datos.START), .NUM(datos.NUM), .DEN(datos.DEN), .COC(datos.COC), .RES(datos.RES), .DONE(datos.DONE));


endmodule
