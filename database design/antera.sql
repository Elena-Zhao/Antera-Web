
create table customer
(
	customer_email char(30) not null unique,
	first_name char(10),
	last_name char(10),
	#May have multiple addresses, considering dividing address into a individual table
	shipping_address varchar(256),
	customer_city char(20),
	customer_state char(15),
	phone_number char(10),
	zipcode int,
    primary key(email)
);

create table doctor
(
	#Do doctors have licence with id on it?
    doctor_id char(10) not null unique,
    first_name varchar(256),
	last_name varchar(256),
	phone_number char(10),
	email char(10) not null unique,
	#dea: Prescription pad number?
	dea varchar(256), 
    primary key(email)
);

create table practice
(
    practice_number varchar(256) not null unique,
    practice_address integer,
	practice_city char(20),
	practice_state char(15),
	phone_number char(9),
	email char(10) not null,
    primary key(practice_id),
    foreign key(report_no) references report
        on delete cascade on update cascade
);

create table belongs_to
(
    doctor_id char(10),
    practice_id varchar(256),
    primary key(doctor_id, practice_id),
    foreign key(doctor_id) references doctor
        on delete cascade on update cascade,
    foreign key(practice_id) references practice
        on delete cascade on update cascade
);

create table prescription
(
    pres_id char(15) not null unique,
    issue_date char(20),
	url varchar(256),
    primary key(pres_id)
	foreign key(doctor_id) references doctor
        on delete cascade on update cascade
	foreign key(infant_id) references infant
        on delete cascade on update cascade	
);

create table infant
(
	#infant_id is given automatically by system
	infant_id char(15) not null unique,
	customer_email char(30) not null unique
    birthday date not null,
    first_name char(10) not null,
	last_name char(10) not null,

	primary key(infant_id),
    #primary key(customer_email, first_name),   ...not elegent
    foreign key(customer_email) references custumer
        on delete cascade on update cascade
);

create table administrator
(
    employee_id unsigned int not null unique,
	first_name char(10) not null,
	last_name char(10) not null,
    permission_group int,
    primary key(dept_no)
);

create table bank_account
(
    account_number integer not null unique,
	billing_address varchar(256),
	billing_state char(10),
	billing_city char(10),
    primary key(account_number),
    foreign key(customer_email) references customer
        on delete cascade on update cascade
);

create table aralyte_order
(
    order_id char(20) not null unique,
    primary key(order_id),
    foreign key(customer_email) references customer
        on delete cascade on update cascade
	foreign key(last_name) references infant
        on delete cascade on update cascade
	foreign key(account_number) references account
        on delete cascade on update cascade	
);

create table first_order
(
    order_id char(20) not null unique,
	billing_address varchar(256),
    billing_state integer,
    primary key(order_id),
    foreign key(practice_id) references practice
        on delete cascade on update cascade
	foreign key(doctor_id) references doctor
        on delete cascade on update cascade
	foreign key(account_number) references account
        on delete cascade on update cascade
);
