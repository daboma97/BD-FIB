CREATE TABLE empleats(
  nempl integer primary key,
  salari integer);

insert into empleats values(1,1000);

insert into empleats values(2,2000);

insert into empleats values(123,3000);

CREATE TABLE dia(
dia char(10));

insert into dia values('dijous');


create table missatgesExcepcions(
	num integer, 
	texte varchar(50)
	);
insert into missatgesExcepcions values(1,'No es poden esborrar empleats el dijous');


Implementar mitjançant disparadors la restricció d''integritat següent: 
No es poden esborrar empleats el dijous
Tigueu en compte que:
- Les restriccions d''integritat definides a la BD (primary key, foreign key,...) es violen amb menys freqüència que la restricció 
	comprovada per aquests disparadors.
- El dia de la setmana serà el que indiqui la única fila que hi ha d''haver sempre insertada a la taula "dia". 
	Com podreu veure en el joc de proves que trobareu al fitxer adjunt, el dia de la setmana és el 'dijous'. 
	Per fer altres proves podeu modificar la fila de la taula amb el nom d''un altre dia de la setmana. 
	IMPORTANT: Tant en el programa com en la base de dades poseu el nom del dia de la setmana en MINÚSCULES.

Cal informar dels errors a través d''excepcions tenint en compte les situacions tipificades a la taula missatgesExcepcions, que podeu trobar definida (amb els inserts corresponents) al fitxer adjunt. 
Concretament en el vostre procediment heu d''incloure, quan calgui, les sentències: 
SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=__;(el número que sigui, depenent de l''error)
RAISE EXCEPTION '%',missatge;
La variable missatge ha de ser una variable definida al vostre procediment, i del mateix tipus que l''atribut corresponent de l''esquema de la base de dades. 

Pel joc de proves que trobareu al fitxer adjunt i la instrucció:
DELETE FROM empleats WHERE salari<=1000 
la sortida ha de ser: 

No es poden esborrar empleats el dijous





create function fdldj() returns trigger as $$
declare 
missatge missatgesExcepcions.texte%type;
dias char(10);
begin 
	select dia into dias from dia;
	if(dias = 'dijous') then
		select texte into missatge
		from missatgesExcepcions 
		where num = 1;
		raise exception '%', missatge;
	end if;
	return null;
end;
$$LANGUAGE plpgsql; 


create trigger no_dl_dj before delete on empleats
for each statement execute procedure fdldj();












