-- Sentències de preparació de la base de dades:
CREATE TABLE empleats(
  nempl integer primary key,
  salari integer);

create table missatgesExcepcions(
	num integer, 
	texte varchar(50)
	);
insert into missatgesExcepcions values(1,'Suma sous esborrats >  Suma sous que queden');

CREATE TABLE TEMP(
             x integer ,
             y integer);

-- Sentències d'esborrat de la base de dades:
drop table empleats;
drop table missatgesExcepcions;
drop table temp;

--------------------------
-- Joc de proves Public
--------------------------

-- Sentències d'inicialització:
insert into empleats values(1,1000);
insert into empleats values(2,2500);
insert into empleats values(123,3000);

-- Dades d'entrada o sentències d'execució:
delete from empleats where salari<=2500;

-- Resultat esperat:
P0001, 0, ERROR: Suma sous esborrats >  Suma sous que queden.



Implementar mitjançant disparadors la restricció d''integritat següent: 
La suma dels sous dels empleats esborrats en una instrucció delete, no pot ser superior a la suma dels sous dels empleats que queden a la BD 
	després de l''esborrat.
	
Tigueu en compte que:
- Per resoldre aquest exercici podeu utilitzar la taula temporal que trobareu al fitxer adjunt. 

Cal informar dels errors a través d''excepcions tenint en compte les situacions tipificades a la taula missatgesExcepcions, 
	que podeu trobar definida (amb els inserts corresponents) al fitxer adjunt. 
	Concretament en el vostre procediment heu d''incloure, quan calgui, les sentències: 
	
SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=__;(el número que sigui, depenent de l''error)
RAISE EXCEPTION '%',missatge;
La variable missatge ha de ser una variable definida al vostre procediment, i del mateix tipus que l''atribut corresponent de l''esquema de la base de dades. 

Pel joc de proves que trobareu al fitxer adjunt i la instrucció: 
DELETE FROM empleats WHERE salari<=2500 
la sortida ha de ser: 

Suma sous esborrats > Suma sous que queden 



create or replace function delempl() returns trigger as $$ 
declare
missatge missatgesExcepcions.texte%type;
begin
	select count(sou) into x from empleats
	--x es la suma del sou dels empleats que queden a la taula--
	--y es la suma del sou dels empleats eliminats--
	if(y > x) then
		select texte into missatge from missatgesExcepcions where num = 1;
		raise exception '%', missatge;
	else 
		
end 



create trigger trig before delete on empleats
for each row execute procedure delempl();





