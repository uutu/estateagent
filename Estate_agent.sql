CREATE TABLE Estate_Agent
(
  Login VARCHAR NOT NULL,
  Password VARCHAR NOT NULL,
  Name VARCHAR NOT NULL,
  Address VARCHAR NOT NULL,
  Agent_ID INT NOT NULL,
  PRIMARY KEY (Agent_ID),
  UNIQUE (Login),
  UNIQUE (Password)
);

INSERT INTO Estate_Agent VALUES ('UA502', 'Bananas', 'Gertrud Schnupp', 'Jarrerstrasse 12', 1);
INSERT INTO Estate_Agent VALUES ('UX518', 'Apples', 'Harald Schnupp', 'Sierichstrasse 44', 2);
INSERT INTO Estate_Agent VALUES ('UD532', 'Oranges', 'Franz Goetz', 'Heimdamm 63', 3);
INSERT INTO Estate_Agent VALUES ('UZ501', 'Kiwis', 'Janika Gelb', 'Helmwiese 22', 4);

CREATE TABLE Estate
(
  Estate_ID INT NOT NULL,
  Square_Area INT NOT NULL,
  City VARCHAR NOT NULL,
  Postal_Code INT NOT NULL,
  Street VARCHAR NOT NULL,
  Number INT NOT NULL,
  Agent_ID INT NOT NULL,
  PRIMARY KEY (Estate_ID),
  FOREIGN KEY (Agent_ID) REFERENCES Estate_Agent(Agent_ID)
);

INSERT INTO Estate VALUES (1, 72, 'Hamburg', 22303, 'Borgweg', 88, 1);
INSERT INTO Estate VALUES (2, 32, 'Hamburg', 22303, 'Goldbeckerstrasse', 28, 1);
INSERT INTO Estate VALUES (3, 102, 'Hamburg', 24307, 'Alsterterasse', 242, 2);
INSERT INTO Estate VALUES (4, 28, 'Hamburg', 26333, 'Heimdamm', 12, 3);
INSERT INTO Estate VALUES (5, 58, 'Hamburg', 22900, 'Gertigstrasse', 121, 3);
INSERT INTO Estate VALUES (6, 76, 'Hamburg', 24703, 'Bachstrasse', 8, 4);
INSERT INTO Estate VALUES (7, 81, 'Hamburg', 29913, 'Saarlandstrasse', 288, 4);
INSERT INTO Estate VALUES (8, 90, 'Hamburg', 29300, 'Stadtparkweg', 62, 4);

CREATE TABLE Apartment
(
  Floor INT NOT NULL,
  Rent FLOAT NOT NULL,
  Rooms INT NOT NULL,
  Balcony BOOLEAN NOT NULL,
  Built_in_Kitchen BOOLEAN NOT NULL,
  Apartment_ID INT NOT NULL,
  Estate_ID INT NOT NULL,
  PRIMARY KEY (Apartment_ID),
  FOREIGN KEY (Estate_ID) REFERENCES Estate(Estate_ID)
);

INSERT INTO Apartment VALUES (6, 650, 4, 't', 't', 1, 2);
INSERT INTO Apartment VALUES (2, 489, 3, 'f', 't', 2, 4);
INSERT INTO Apartment VALUES (5, 780, 3, 't', 't', 3, 5);
INSERT INTO Apartment VALUES (4, 854, 2, 't', 't', 4, 6);

CREATE TABLE House
(
  Floors INT NOT NULL,
  Price FLOAT NOT NULL,
  Garden BOOLEAN NOT NULL,
  House_ID INT NOT NULL,
  Estate_ID INT NOT NULL,
  PRIMARY KEY (House_ID),
  FOREIGN KEY (Estate_ID) REFERENCES Estate(Estate_ID)
);

INSERT INTO House VALUES (1, 128900, 't', 1,1);
INSERT INTO House VALUES (2, 152500, 'f', 2, 3);
INSERT INTO House VALUES (1, 189000, 'f', 3, 7);
INSERT INTO House VALUES (1, 174990, 't', 4, 8);

CREATE TABLE Person
(
  First_Name VARCHAR NOT NULL,
  Name VARCHAR NOT NULL,
  Address VARCHAR NOT NULL,
  Person_ID INT NOT NULL,
  PRIMARY KEY (Person_ID)
);

INSERT INTO Person VALUES ('Kalle', 'Koivula', 'Erdweg 128',1);
INSERT INTO Person VALUES ('Heidi', 'Blum', 'Erdweg 128',2);
INSERT INTO Person VALUES ('Charli', 'Fischer', 'Sturmstrasse 8',3);
INSERT INTO Person VALUES ('Jan', 'Messer', 'Kanalstrasse 92',4);

CREATE TABLE Contract
(
  Contract_No INT NOT NULL,
  Date DATE NOT NULL,
  Place VARCHAR NOT NULL,
  PRIMARY KEY (Contract_No)
);

INSERT INTO Contract VALUES (1, '04-08-2020', 'Hamburg');
INSERT INTO Contract VALUES (2, '08-04-2020', 'Hamburg');
INSERT INTO Contract VALUES (3, '01-01-2020', 'Hamburg');
INSERT INTO Contract VALUES (4, '12-07-2020', 'Hamburg');

CREATE TABLE Tenancy_Contract
(
  Start_Date DATE NOT NULL,
  Duration INT NOT NULL,
  Additional_Costs FLOAT NOT NULL,
  Contract_ID INT NOT NULL,
  Contract_No INT NOT NULL,
  PRIMARY KEY (Contract_ID),
  FOREIGN KEY (Contract_No) REFERENCES Contract(Contract_No)
);

INSERT INTO Tenancy_Contract VALUES ('04-08-2020', 12, 22.90, 1, 1);
INSERT INTO Tenancy_Contract VALUES ('08-04-2020', 12, 15.90, 2, 2);

CREATE TABLE Purchase_Contract
(
  No_of_Installments INT NOT NULL,
  Interest_Rate FLOAT NOT NULL,
  Contract_ID INT NOT NULL,
  Contract_No INT NOT NULL,
  PRIMARY KEY (Contract_ID),
  FOREIGN KEY (Contract_No) REFERENCES Contract(Contract_No)
);

INSERT INTO Purchase_Contract VALUES (36, 2.95, 1, 3);
INSERT INTO Purchase_Contract VALUES (42, 3.25, 2, 4);

CREATE TABLE Rental_Contract
(
  Apartment_ID INT NOT NULL,
  Renter_ID INT NOT NULL,
  Contract_ID INT NOT NULL,
  PRIMARY KEY (Apartment_ID, Renter_ID, Contract_ID),
  FOREIGN KEY (Apartment_ID) REFERENCES Apartment(Apartment_ID),
  FOREIGN KEY (Renter_ID) REFERENCES Person(Person_ID),
  FOREIGN KEY (Contract_ID) REFERENCES Tenancy_Contract(Contract_ID)
);

INSERT INTO Rental_Contract VALUES (1, 1, 1);
INSERT INTO Rental_Contract VALUES (2, 2, 2);

CREATE TABLE Buy_Contract
(
  Buyer_ID INT NOT NULL,
  House_ID INT NOT NULL,
  Person_ID INT NOT NULL,
  PRIMARY KEY (Buyer_ID, House_ID, Person_ID),
  FOREIGN KEY (Buyer_ID) REFERENCES Purchase_Contract(Contract_ID),
  FOREIGN KEY (House_ID) REFERENCES House(House_ID),
  FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID)
);

INSERT INTO Buy_Contract VALUES (1, 1, 3);
INSERT INTO Buy_Contract VALUES (2, 2, 4);
