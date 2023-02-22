CREATE TABLE tblRoles 
(
	rol_ID								INT IDENTITY (1,1) NOT NULL,
	rol_Descripcion						NVARCHAR(100)	   NOT NULL

	CONSTRAINT PK_tblRoles_rol_ID		PRIMARY KEY (rol_ID)
);

CREATE TABLE tblPantallas
(
		p_ID								INT IDENTITY (1,1)	NOT NULL,
		p_Descripción						NVARCHAR(100)		NOT NULL

		CONSTRAINT PK_tblPantallas_p_ID		PRIMARY KEY(p_ID)	
);

CREATE TABLE tblRolPantallas
(
		rp_ID								INT IDENTITY(1,1)	NOT NULL,
		rp_RolID							INT,
		rp_PantallasID						INT

		CONSTRAINT PK_tblRolPantallas_rp_ID									PRIMARY KEY (rp_ID),
		CONSTRAINT FK_tblRolPantallas_rp_RolID_tblRoles_rol_ID				FOREIGN KEY (rp_RolID)			REFERENCES tblRoles (rol_ID),
		CONSTRAINT FK_tblRolPantallas_rp_PantallasID_tblPantallas_p_ID		FOREIGN KEY (rp_PantallasID)	REFERENCES tblPantallas (p_ID)
);