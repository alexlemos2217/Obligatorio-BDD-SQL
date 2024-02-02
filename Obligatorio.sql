
-- ╔═══════════════════════════════════════════════════════ OBLIGATORIO BASE DE DATOS ═══════════════════════════════════════════════════════╗ --
use master
go
-- ╔═══════════════════════════════════════════════════════ CREACIÓN DE LA BASE DE DATOS ═══════════════════════════════════════════════════════╗ --
-- Determina si está la base de datos Obligatorio --
if exists(select * from SysDataBases where name = 'Obligatorio')
begin
	-- Borra la base de datos --
	drop database Obligatorio
end
go

-- Crea la base de datos Obligatorio --
create database Obligatorio
go

use Obligatorio
go

-- ╔═══════════════════════════════════════════════════════ TABLAS BASE DE DATOS ═══════════════════════════════════════════════════════╗ --

-- COMPANIAS --
create table COMPANIAS
(
	nombre varchar(50) primary key,
	direccion varchar(50) not null,
	telefono varchar(50)
)
go

-- TERMINALES --
create table TERMINALES
(
	codigo varchar(6) primary key check(LEN(codigo) = 6 AND codigo LIKE '[a-z][a-z][a-z][a-z][a-z][a-z]'),
	ciudad varchar(50) not null
)
go

create table NACIONALES
(
	codigo varchar(6) foreign key references TERMINALES(codigo),
	taxis bit not null

	primary key(codigo)
)
go

create table INTERNACIONALES
(
	codigo varchar(6) foreign key references TERMINALES(codigo),
	pais varchar(50) not null
	
	primary key(codigo)
)
go

-- VIAJES --
create table VIAJES
(
    nroInterno int identity(1, 1) primary key,
    fecHorSalida datetime not null,
    fecHorLlegada datetime not null, 
    cantPasajeros int check (cantPasajeros >= 1 and cantPasajeros <= 50) not null,
    precioBoleto int check (precioBoleto >= 0) not null,
    anden int check (anden >= 1 and anden <= 35) not null,
    codigo varchar(6) not null,
    nombre varchar(50) not null,
	ciudad varchar(50) not null
    
    foreign key (codigo) references TERMINALES(codigo),
    
    foreign key (nombre) references COMPANIAS(nombre),

	foreign key (ciudad) references TERMINALES(ciudad),
    
    check(fecHorSalida < fecHorLlegada)
)
go


-- ╔═══════════════════════════════════════════════════════ DATOS DE PRUEBA ═══════════════════════════════════════════════════════╗ --
-- Se insertan datos en la tabla COMPANIAS --
insert into COMPANIAS (nombre, direccion) values ('Rutas del Plata', 'Virrey Arredondo 3710'),
												 ('Núñez', 'Tres Cruces Bv. Artigas 1825'),
												 ('Agencia Central', 'Virrey Arredondo 1263'),
												 ('Buquebus', 'Avenida 18 de Julio 1299'),
												 ('Cauvi', 'Avenida General Rivera 5521'),
												 ('Chadre', 'Avenida 8 de Octubre 3744'),
												 ('Chevial', 'Avenida Italia 3241'),
												 ('Bruno', 'Bulevar Artigas 2276'),
												 ('Cita', 'Bulevar España 3321'),
												 ('Turismar', 'Avenida Luis Alberto de Herrera 2902'),
												 ('Colonia Express', 'Avenida Luis Batlle Berres 2122'),
												 ('Turil', 'Avenida Agraciada 980'),
												 ('Condor', 'Convención 1399'),
												 ('TTL', 'Colonia 1321'),
												 ('Copa Turismo', 'Durazno 2750'),
												 ('Sabelín', 'Río Branco 1109'),
												 ('Copay', 'Paysandú 880'),
												 ('Rutas del Sol', 'Río Negro 2345'),
												 ('Copsa', 'Ciudadela 2050'),
												 ('Nossar', 'Soriano 1234'),
												 ('Intertur', 'Andes 779'),
												 ('Cot', 'Mercedes 1121'),
												 ('Expreso Minuano', 'Cerrito 1234'),
												 ('Cotmi', 'Isla de Flores 3102'),
												 ('Expreso Chago', 'Carlos Gardel 1590'),
												 ('Cromin', 'Constituyente 2052'),
												 ('Encon', 'Sarmiento 2064'),
												 ('Cut Corporación', 'Cuareim 1133'),
												 ('Emdal', 'San José 1321'),
												 ('Cynsa', 'Uruguay 588'),
												 ('El Rápido Internacional', '2891'),
												 ('El Norteño', '26 de Marzo 3018'),
												 ('Ega', 'Avenida Brasil 2290')

-- Se insertan datos en la tabla TELEFONOS --
insert into TELEFONOS (nombre, telefono) values ('Rutas del Plata', '24025372'),
												('Rutas del Plata', '092334222'),
												('Núñez', '44748882'),
												('Agencia Central', '29021064'),
												('Buquebus', '24018998'),
												('Cauvi', '09824019196'),
												('Chadre', '096777456'),
												('Chevial', '2925884'),
												('Bruno', '29014402'),
												('Cita', '22035751'),
												('Turismar', '24090999'),
												('Turismar', '099872312'),
												('Colonia Express', '24038050'),
												('Turil', '46752291'),
												('Condor', '24204456'),
												('TTL', '099333567'),
												('Copa Turismo', '24214409'),
												('Sabelín', '46589923'),
												('Copay', '099342311'),
												('Copay', '42559988'),
												('Rutas del Sol', '44537745'),
												('Copsa', '096053325'),
												('Nossar', '095033160'),
												('Intertur', '46590212'),
												('Cot', '094388701'),
												('Cot', '22336744'),
												('Expreso Minuano', '20204912'),
												('Cotmi', '20307782'),
												('Expreso Chago', '091223987'),
												('Cromin', '092999435'),
												('Encon', '097097765'),
												('Cut Corporación', '47287743'),
												('Emdal', '093528923'),
												('Cynsa', '096484897'),
												('El Rápido Internacional', '46425167'),
												('El Norteño', '46798821'),
												('Ega', '099012211'),
												('Ega', '46778232')

-- Se insertan valores en la tabla TERMINALES -- 
insert into TERMINALES (codigo, ciudad) values ('rutpla', 'Rio Branco'),
											   ('nuneza', 'Melo'),
											   ('agecen', 'Montevideo'),
											   ('buqueb', 'Colonia del Sacramento'),
											   ('cauvia', 'Priápolis'),
											   ('chauno', 'Artigas'),
											   ('cheuno', 'Carmelo'),
											   ('bruuno', 'Rivera'),
											   ('cituno', 'Pando'),
											   ('turmar', 'Chuy'),
											   ('colexp', 'Colonia del Sacramento'),
											   ('turuno', 'Artigas'),
											   ('conuno', 'Tala'),
											   ('ttluno', 'Treinta y Tres'),
											   ('coptur', 'Rincón'),
											   ('sabuno', 'Vergara'),
											   ('copaya', 'Mariscala'),
											   ('rutsol', 'Piriápolis'),
											   ('copsaa', 'Sauce'),
											   ('nossar', 'Ciudad del Plata'),
											   ('intert', 'Atlántida'),
											   ('cotuno', 'El Pinar'),
											   ('expmin', 'Paso de los Toros'),
											   ('cotmia', 'Ansina'),
											   ('expcha', 'Fraile Muerto'),
											   ('cromin', 'Tranqueras'),
											   ('encona', 'Baltasar Brum'),
											   ('cutcor', 'Delta del Tigre'),
											   ('emdala', 'Pinamar'),
											   ('cynsaa', 'Trinidad'),
											   ('elrain', 'Mercedes'),
											   ('elnort', 'Rosario'),
											   ('egauno', 'Rio Branco')

-- Se insertan datos en la tabla (terminales) NACIONALES --
insert into NACIONALES (codigo, taxis) values ('rutpla', 1),
											  ('nuneza', 1),
											  ('agecen', 1),
											  ('cauvia', 0),
											  ('chauno', 0),
											  ('cituno', 1),
											  ('turmar', 0),
											  ('conuno', 0),
											  ('ttluno', 1),
											  ('coptur', 0),
											  ('sabuno', 1),
											  ('copaya', 1),
											  ('rutsol', 1),
											  ('copsaa', 1),
											  ('nossar', 0),
											  ('intert', 1),
											  ('cotuno', 0),
											  ('expmin', 1),
											  ('cotmia', 0),
											  ('expcha', 1),
											  ('cromin', 1),
											  ('encona', 0),
											  ('cutcor', 0),
											  ('emdala', 1),
											  ('cynsaa', 1),
											  ('elnort', 0)

-- Se insertan datos en la tabla (terminales) INTERNACIONALES --
insert into INTERNACIONALES (codigo, pais) values ('buqueb', 'Argentina'),
												  ('cheuno', 'Argentina'),
												  ('bruuno', 'Brasil'),
												  ('colexp', 'Argentina'),
												  ('turuno', 'Brasil'),
												  ('elrain', 'Colombia'),
												  ('egauno','Brasil')

-- Se insertan datos en la tabla VIAJES --
insert into VIAJES (fecHorSalida, fecHorLlegada, cantPasajeros, precioBoleto, anden, codigo, nombre) values ('20230910 07:00:00', '20230910 13:00:00', 32, 1045, 20, 'rutpla', 'Rutas del Plata'),
																											('20230911 08:00:00', '20230911 12:00:00', 40, 780, 11, 'nuneza', 'Núñez'),
																											('20230912 10:30:00', '20230912 15:45:00', 30, 650, 22, 'agecen', 'Agencia Central'),
																											('20230913 09:15:00', '20230913 13:30:00', 33, 870, 12, 'buqueb', 'Buquebus'),
																											('20230914 11:00:00', '20230914 15:00:00', 20, 999, 30, 'cauvia', 'Cauvi'),
																											('20230915 14:45:00', '20230915 19:30:00', 44, 370, 21, 'chauno', 'Chadre'),
																											('20230901 08:00:00', '20230901 12:00:00', 50, 550, 17, 'cheuno', 'Chevial'),
																											('20230902 09:30:00', '20230902 13:30:00', 22, 670, 1, 'bruuno', 'Bruno'),
																											('20230903 10:45:00', '20230903 15:30:00', 39, 887, 5, 'cituno', 'Cita'),
																											('20230904 11:15:00', '20230904 15:45:00', 28, 490, 8, 'turmar', 'Turismar'),
																											('20230905 13:00:00', '20230905 17:30:00', 27, 2200, 10, 'colexp', 'Colonia Express'),
																											('20230906 14:30:00', '20230906 19:15:00', 45, 1100, 2, 'turuno', 'Turil'),
																											('20230907 15:45:00', '20230907 20:00:00', 28, 790, 7, 'conuno', 'Condor'),
																											('20230908 16:30:00', '20230908 21:15:00', 42, 990, 3,'ttluno', 'TTL'),
																											('20230909 17:15:00', '20230909 22:00:00', 31, 740, 13, 'coptur', 'Copa Turismo'),
																											('20230910 18:00:00', '20230910 23:00:00', 29, 599, 15, 'sabuno', 'Sabelín'),
																											('20230911 08:30:00', '20230911 12:30:00', 37, 1290, 14, 'copaya', 'Copay'),
																											('20230912 09:15:00', '20230912 13:45:00', 49, 1100, 18, 'rutsol', 'Rutas del Sol'),
																											('20230913 10:00:00', '20230913 14:00:00', 48, 1300, 16, 'copsaa', 'Copsa'),
																											('20230914 11:30:00', '20230914 16:30:00', 47, 980, 20, 'nossar', 'Nossar'),
																											('20230915 12:45:00', '20230915 17:15:00', 41, 1150, 35, 'intert', 'Intertur'),
																											('20230916 13:15:00', '20230916 18:00:00', 37, 1030, 34, 'cotuno', 'Cot'),
																											('20230917 14:00:00', '20230917 19:30:00', 36, 870, 32, 'expmin', 'Expreso Minuano'),
																											('20230918 15:30:00', '20230918 20:15:00', 39, 516, 33, 'cotmia', 'Cotmi'),
																											('20230919 16:45:00', '20230919 21:30:00', 27, 216, 29, 'expcha', 'Expreso Chago'),
																											('20230920 17:30:00', '20230920 22:45:00', 33, 450, 28, 'cromin', 'Cromin'),
																											('20230921 08:45:00', '20230921 13:30:00', 25, 880, 27, 'encona', 'Encon'),
																											('20230922 09:30:00', '20230922 14:15:00', 38, 930, 26, 'cutcor', 'Cut Corporación'),
																											('20230923 10:15:00', '20230923 15:00:00', 40, 1100, 25, 'emdala', 'Emdal'),
																											('20230924 11:45:00', '20230924 16:30:00', 29, 1312, 24, 'cynsaa', 'Cynsa'),
																											('20230925 12:30:00', '20230925 17:15:00', 48, 1690, 23, 'elrain', 'El Rápido Internacional'),
																											('20230926 13:15:00', '20230926 18:00:00', 28, 870, 19, 'elnort', 'El Norteño'),
																											('20230927 14:45:00', '20230927 19:30:00', 49, 1790, 4, 'egauno', 'Ega')
																										
-- ╔═══════════════════════════════════════════════════════ ELIMINAR TERMINAL ═══════════════════════════════════════════════════════╗ --
-- Procedimiento almacenado para eliminar una terminal --
Create Procedure EliminarTerminal
@codigo varchar(6)
as
begin
	-- Se inicia una transacción debido a que involucra múltiples operaciones
	Begin Tran
		
		-- Verificar si la terminal existe
		if NOT exists  (select * from TERMINALES where codigo = @codigo)
		begin
			rollback -- En caso de error revierte todo
			return -1
		end

		-- Verificar si hay viajes asociados a la terminal
		if EXISTS (select * from VIAJES where codigo = @codigo)
		begin
			rollback
			return -2
		end

		delete from TERMINALES
		where codigo = @codigo
		if (@@ERROR != 0)
		begin
			rollback
			return -3
		end
		-- Si no hay errores realiza el commit y elimina la terminal
		Commit Tran
		return 1
end
go

-- Ejecutar el procedimiento creado--
declare @retorno int
exec @retorno = EliminarTerminal 'rutpla' /* 'noexis' */ /* 'rutpla' */

if @retorno = -1
	print 'No existe una terminal con ese código'
else if @retorno = -2
	print 'Terminal con viajes asociados, no se puede eliminar'
else if @retorno = -3
	print 'Ocurrió un error inesperado'
else if @retorno = 1
	print 'La terminal se eliminó correctamente'

	-- Datos para probar el procedimiento --
-- Intenta eliminar una terminal que no existe (devuelve -1)
exec EliminarTerminal 'noexis'
go
-- Intenta eliminar una terminal con viajes asociados (devuelve -2)
exec EliminarTerminal 'rutpla'
go

-- ╔═══════════════════════════════════════════════════════ MODIFICAR VIAJE ═══════════════════════════════════════════════════════╗ --
-- Procedimiento almacenado para modificar un viaje --
Create procedure ModificarViaje
@codigoTerminal varchar(6),
@fecHorSalida datetime, 
@fecHoraLlegada datetime,
@cantPasajeros int,
@precioBoleto int,
@anden int
as
begin
	-- Verificar si el viaje existe
	if NOT exists (select * from VIAJES where codigo = @codigoTerminal)
	begin
		return -1
	end

	-- Verificar si el viaje ya se ha realizado
	if @fecHorSalida < GETDATE()
	begin
		return -2
	end

	-- Modificación del viaje
	UPDATE VIAJES
	SET
		fecHorSalida = @fecHorSalida,
		@fecHoraLlegada = @fecHoraLlegada,
		cantPasajeros = @cantPasajeros,
		precioBoleto = @precioBoleto,
		anden = @anden
	where
		codigo = @codigoTerminal;
	if (@@ERROR != 0)
	begin
		return -3
	end

	return 1

end
go

-- Ejecutar el procedimiento creado --
declare @retorno int
exec @retorno = ModificarViaje 'egauno', '2023-09-27 14:45:00', '2023-09-27 19:30:00', 49, 1790, 4;

if @retorno = -1
	print 'El viaje no existe'
else if @retorno = -2
	print 'El viaje ya se ha realizado'
else if @retorno = -3
	print 'Ocurrió un error inesperado'
else if @retorno = 1
	print 'Viaje modificado con éxito'

	-- Datos para probar el procedimiento --
-- Intenta modificar un viaje que existe y aún no ha ocurrido (lo modifica correctamente)
exec ModificarViaje 'egauno', '2023-09-27 14:45:00', '2023-09-27 19:30:00', 49, 1790, 4;

-- Intenta modificar un viaje que no existe (devuelve -1)
exec ModificarViaje 'nunezb', '2023-09-15 08:00:00', '2023-09-15 12:00:00', 35, 950, 15;

-- Intenta modificar un viaje que ya ha ocurrido (devuelve -2)
exec ModificarViaje 'nuneza', '2023-09-10 08:00:00', '2023-09-10 12:00:00', 35, 950, 15;
INSERT COMPANIAS(nombre, direccion, telefono) VALUES(@Nombre, @Direccion, @Telefono)
 -- ╔═══════════════════════════════════════════════════════ AGREGAR COMPAÑIA ═══════════════════════════════════════════════════════╗ --

CREATE PROCEDURE AgregarCompania
@Nombre varchar(20),
@Direccion varchar(20),
@Telefono int
AS
BEGIN 
	if EXISTS (SELECT nombre FROM Companias WHERE nombre = @nombre)
		RETURN -1
	
	INSERT INTO COMPANIAS(nombre, direccion, telefono) VALUES(@Nombre, @Direccion, @Telefono)
	IF(@@Error <> 0)
		RETURN -2
END
go


CREATE PROCEDURE ModificarCompania
@Nombre varchar(20),
@Direccion varchar(20),
@Telefono int
AS
BEGIN
	if NOT EXISTS (SELECT nombre FROM COMPANIAS WHERE nombre = @nombre)
		return -1

	else
	begin
		UPDATE COMPANIAS SET direccion = @Direccion, telefono = @Telefono WHERE nombre = @Nombre
		if @@ERROR <> 0
		return -2

		return 1
	END
END
GO

CREATE PROCEDURE BuscarCompania
@nombre varchar(50)
AS
BEGIN
	SELECT *
	FROM COMPANIAS
	WHERE nombre = @nombre
END
GO


 -- ╔═══════════════════════════════════════════════════════ AGREGAR VIAJE ═══════════════════════════════════════════════════════╗ --

 -- Procedimiento almacenado para agregar un viaje --
Create procedure AgregarViaje
@fecHoraSalida datetime,
@fecHoraLlegada datetime,
@cantPasajeros int,
@precioBoleto int,
@anden int,
@codigo varchar(6),
@nombre varchar(50)
@ciudad varchar(50)
as
begin
    declare @retorno int
    declare @nroInterno int

    -- Verificar si la terminal existe
    if NOT exists (select * from TERMINALES where codigo = @codigo)
    begin
        return -1
    end

    -- Verificar si la compañía existe
    if NOT exists (select * from COMPANIAS where nombre = @nombre)
    begin
        return -2
    end

    -- Verificar cantidad de pasajeros
    if @cantPasajeros < 1 OR @cantPasajeros > 50
    begin
        return -3
    end

    -- Verificar precio del boleto
    if @precioBoleto < 0
    begin
        return -4
    end

    -- Verificar anden
    if @anden < 1 OR @anden > 35
    begin
        return -5
    end

    -- Verificar fechas
    if @fecHoraSalida >= @fecHoraLlegada
    begin
        return -6
    end

    -- Con los controles realizados, se inserta el nuevo viaje
    insert into VIAJES (fecHorSalida, fecHorLlegada, cantPasajeros, precioBoleto, anden, codigo, nombre)
    values (@fecHoraSalida, @fecHoraLlegada, @cantPasajeros, @precioBoleto, @anden, @codigo, @nombre)

    -- Devolver el Nro. Interno
    SET @nroInterno = SCOPE_IDENTITY()

    -- Devolver el número interno como resultado
    SET @retorno = @nroInterno
    return @retorno
end
go

-- Ejecutar procedimiento almacenado creado --
declare @retorno int
declare @nroInterno int
exec @retorno = AgregarViaje '2023-10-01 09:00:00', '2023-10-01 13:00:00', 40, 800, 10, 'nuneza', 'Núñez'

if @retorno > 0
begin
    set @nroInterno = @retorno
    print 'Viaje agregado con éxito. Número interno del viaje: ' + CAST(@nroInterno AS varchar(10))
end
else if @retorno = -1
    print 'La terminal no existe'
else if @retorno = -2
    print 'La compañía no existe'
else if @retorno = -3
    print 'Cantidad de pasajeros no válida (rango de 1-50)'
else if @retorno = -4
    print 'El precio del boleto no puede ser negativo'
else if @retorno = -5
    print 'Anden no válido (rango de 1 a 35)'
else if @retorno = -6
    print 'Fecha no válida (La fecha de salida debe ser menor a la de llegada)'

	-- Datos para probar el procedimiento --
-- Intenta agregar un nuevo viaje válido (devuelve el número generado para el viaje)
exec AgregarViaje '2023-10-01 09:00:00', '2023-10-01 13:00:00', 40, 800, 10, 'nuneza', 'Núñez'

-- Intenta agregar un nuevo viaje con una terminal inexistente (devuelve -1)
exec AgregarViaje '2023-10-02 10:00:00', '2023-10-02 14:00:00', 30, 600, 5, 'Terminal Inexistente', 'Núñez'

-- Intenta agregar un nuevo viaje con una compañía inexistente (devuelve -2)
exec AgregarViaje '2023-10-03 11:00:00', '2023-10-03 15:00:00', 25, 550, 8, 'nuneza', 'Compañia Inexistente'

-- Intenta agregar un nuevo viaje con una cantidad de pasajeros no válida (devuelve -3)
exec AgregarViaje '2023-10-04 12:00:00', '2023-10-04 16:00:00', 0, 700, 15, 'nuneza', 'Núñez'

-- Intenta agregar un nuevo viaje con un precio de boleto negativo (devuelve -4)
exec AgregarViaje '2023-10-05 13:00:00', '2023-10-05 17:00:00', 35, -500, 20, 'nuneza', 'Núñez'

-- Intenta agregar un nuevo viaje con un anden no válido (ddevuelve -5)
exec AgregarViaje '2023-10-06 14:00:00', '2023-10-06 18:00:00', 30, 750, 100, 'nuneza', 'Núñez'

-- Intenta agregar un nuevo viaje con una fecha de salida mayor o igual a la de llegada (devuelve -6)
exec AgregarViaje '2023-10-07 15:00:00', '2023-10-07 14:00:00', 28, 620, 10, 'nuneza', 'Núñez'

-- ╔═══════════════════════════════════════════════════════ LISTADO DE VIAJES ═══════════════════════════════════════════════════════╗ --
-- Procedimiento almacenado para consultar viajes --
Create procedure ListadoViajes
as
begin
	SELECT
		VIAJES.nroInterno AS [Nro. Interno],
		VIAJES.fecHorSalida AS [Fecha y hora de salida],
		VIAJES.fecHorLlegada AS [Fecha y hora de llegada],
		VIAJES.cantPasajeros AS [Cantidad de pasajeros],
		VIAJES.precioBoleto AS [Precio del boleto],
		VIAJES.anden AS [Anden],
		VIAJES.codigo AS [Código],
		VIAJES.nombre AS [Nombre],
		TERMINALES.ciudad AS [Destino]

	FROM
		VIAJES
	INNER JOIN
		TERMINALES ON VIAJES.codigo = TERMINALES.codigo
	INNER JOIN
		COMPANIAS ON VIAJES.nombre = COMPANIAS.nombre
end
go

-- Ejecutar procedimiento almacenado --
exec ListadoViajes
go

-- ╔══════════════════════════════════════════════════ TOTAL DE VIAJES POR COMPAÑÍA ══════════════════════════════════════════════════╗ --
-- Procedimiento almacenado para listar el total de viajes por compañía --
Create procedure TotalViajesCompanias
as
begin
	SELECT
		COMPANIAS.nombre AS [Nombre Compañía],
		COUNT (VIAJES.nroInterno) AS [Total de viajes]
	FROM
		COMPANIAS
	LEFT JOIN
		VIAJES ON COMPANIAS.nombre = VIAJES.nombre
	GROUP BY
		COMPANIAS.nombre
end
go

-- Ejecutar procedimiento almacenado --
exec TotalViajesCompanias
go

-- ╔══════════════════════════════════════════════════ TOTAL VIAJES INTERNACIONALES ══════════════════════════════════════════════════╗ --
-- Procedimiento almacenado para listar el total de viajes internacionales --
create procedure TotalViajesIntCompanias
as
begin
	SELECT
		COMPANIAS.nombre AS [Nombre de la Compañía],
		COUNT (VIAJES.nroInterno) AS [Cantidad de viajes internacionales]

	FROM
		COMPANIAS
	INNER JOIN
		VIAJES ON COMPANIAS.nombre = VIAJES.nombre
	INNER JOIN
		TERMINALES ON VIAJES.codigo = TERMINALES.codigo
	WHERE
		TERMINALES.codigo IN (select distinct codigo FROM INTERNACIONALES)
	GROUP BY
		COMPANIAS.nombre
end
go

exec TotalViajesIntCompanias
go

