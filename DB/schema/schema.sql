CREATE SCHEMA IF NOT EXISTS escwebapp;

-- ************************************** escwebapp.users

CREATE TABLE escwebapp.users
(
    User_ID        bigserial NOT NULL,
    User_Name      text NOT NULL,
    Pass_Word_Hash text NOT NULL,
    Name           text NOT NULL,
    Created_At     timestamp NOT NULL DEFAULT NOW(),
    E_Mail_Address text NOT NULL,
    CONSTRAINT PK_users PRIMARY KEY ( User_ID )
);


-- ************************************** escwebapp.member_countries

CREATE TABLE escwebapp.member_countries
(
    Country_ID      bigserial NOT NULL,
    Country_Name    text NOT NULL,
    Big_Five_Member boolean NOT NULL DEFAULT FALSE,
    CONSTRAINT PK_member_countries PRIMARY KEY ( Country_ID )
);

-- ************************************** escwebapp.contest

CREATE TABLE escwebapp.contest
(
    Contest_Year      bigserial NOT NULL,
    Country_ID_HOST   bigserial NOT NULL,
    Number_Of_Contestants   bigserial NOT NULL,
    CONSTRAINT PK_contest PRIMARY KEY ( Contest_Year ),
    CONSTRAINT FK_Country_ID1 FOREIGN KEY ( Country_ID_HOST ) REFERENCES escwebapp.member_countries ( Country_ID )
);

CREATE INDEX FK_Country1 ON escwebapp.contest
    (
     Country_ID_HOST
        );


-- ************************************** escwebapp.user_ranking

CREATE TABLE escwebapp.user_ranking
(
    Country_ID   bigserial NOT NULL,
    User_ID      bigserial NOT NULL,
    Contest_Year bigserial NOT NULL,
    Points_Given bigserial NOT NULL,
    CONSTRAINT PK_user_ranking PRIMARY KEY ( User_ID, Country_ID, Contest_Year),
    CONSTRAINT FK_Country_ID2 FOREIGN KEY ( Country_ID ) REFERENCES escwebapp.member_countries ( Country_ID ),
    CONSTRAINT FK_User_ID1 FOREIGN KEY ( User_ID ) REFERENCES escwebapp.users ( User_ID ),
    CONSTRAINT FK_Contest_Year1 FOREIGN KEY ( Contest_Year ) REFERENCES escwebapp.contest ( Contest_Year )
);

CREATE INDEX FK_Country2 ON escwebapp.user_ranking
    (
     Country_ID
        );

CREATE INDEX FK_User1 ON escwebapp.user_ranking
    (
     User_ID
        );

CREATE INDEX FK_Contest1 ON escwebapp.user_ranking
    (
     Contest_Year
        );

-- ************************************** escwebapp.official_ranking

CREATE TABLE escwebapp.official_ranking
(
    Country_ID   bigserial NOT NULL,
    Contest_Year bigserial NOT NULL,
    Points_Given bigserial NOT NULL,
    CONSTRAINT PK_official_ranking PRIMARY KEY ( Country_ID, Contest_Year),
    CONSTRAINT FK_Country_ID3 FOREIGN KEY ( Country_ID ) REFERENCES escwebapp.member_countries ( Country_ID ),
    CONSTRAINT FK_Contest_Year2 FOREIGN KEY ( Contest_Year ) REFERENCES escwebapp.contest ( Contest_Year )
);

CREATE INDEX FK_Country3 ON escwebapp.official_ranking
    (
     Country_ID
        );

CREATE INDEX FK_Contest2 ON escwebapp.official_ranking
    (
     Contest_Year
        );