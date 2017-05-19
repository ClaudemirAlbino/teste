/*****EXEMPLO 01********/
SELECT           O.NAME AS TABELA,
                 C.NAME AS COLUNA,
                 T.NAME AS TIPODADOS,
                 C.MAX_LENGTH AS TAMANHO
            FROM SYS.ALL_OBJECTS O
                 INNER JOIN SYS.ALL_COLUMNS C ON O.OBJECT_ID=C.OBJECT_ID
                 INNER JOIN SYS.TYPES T ON C.USER_TYPE_ID=T.USER_TYPE_ID
            WHERE O.TYPE='U'
                 AND C.NAME = 'DATA_DE_VENCIMENTO'
            ORDER BY 1,2
/****EXEMPLO 02********/
USE [Lyceum]
GO
/*Em ambos os casos tem que informar o database*/
declare @vOpcaoXtype varchar(1), @vOpcaoPesquisa varchar(2), @vArgumento varchar (24)
set @vOpcaoXtype = 'u'        --'U' - Tabelas
                              --'P' - Procedures
set @vOpcaoPesquisa = 'sc'    --'sc' - Column Name   -- é aqui que se coloca a opcao de pesquisa por campo ou tabela
                              --'so' - Object Name
------------------------------------------------------------
set @vArgumento = 'CURSO'    -- é aqui que se escreve o nome do campo ou tabela, ou procedure
------------------------------------------------------------
SELECT SC.NAME as 'Column Name', SO.NAME as 'Object Name', SO.XTYPE as XType
       FROM dbo.syscolumns SC, dbo.sysobjects SO
WHERE SC.ID = SO.ID
  and @vOpcaoXtype in (SO.XTYPE,'')
  and ((sc.NAME LIKE '%'+@vArgumento+'%' and @vOpcaoPesquisa = 'sc') or (so.NAME LIKE '%'+@vArgumento+'%' and @vOpcaoPesquisa = 'so'))
--order by case when @vOpcaoPesquisa = 'sc' then sc.NAME else so.Name end
order by SO.NAME
