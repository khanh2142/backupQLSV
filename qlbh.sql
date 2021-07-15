create database qlbh
use qlbh

create table hang
(mahang char(50) primary key,
tenhang nvarchar(50),
dongia float,
ghichu nvarchar(100))

create table khachhang 
(makhach char(50) primary key,
tenkhach nvarchar(50),
diachi nvarchar(100))

create table hoadon 
(mahd char(50) primary key,
makhach char(50),
ngayhoadon date,
ghichu nvarchar(100),
constraint fk_hoaodn_khachhang foreign key (makhach) references khachhang(makhach))

create table cthd 
(mahd char(50),
mahang char(50),
soluong int,
constraint fk_cthd_hoadon foreign key (mahd) references hoadon(mahd),
constraint fk_cthd_hang foreign key (mahang) references hang(mahang))

set dateformat dmy
select * from hang
select * from khachhang

exec proc_add_khach 'khach01',N'Long',N'Hà Nội'
exec proc_add_khach 'khach02',N'Vân',N'Hà Nội'
exec proc_add_khach 'khach03',N'Quyền',N'Hà Nội'

exec proc_add_hoadon 'hd01','khach01','15/7/2021',''


create proc proc_add_hang @mahang char(50),@tenhang nvarchar(50),@dongia float,@ghichu nvarchar(100)
as
begin
	insert hang(mahang,tenhang,dongia,ghichu) values (@mahang,@tenhang,@dongia,@ghichu)
end

create proc proc_add_khach @makhach char(50),@tenkhach nvarchar(50),@diachi nvarchar(100)
as
begin
	insert khachhang(makhach,tenkhach,diachi) values (@makhach,@tenkhach,@diachi)
end

create proc proc_add_hoadon @mahd char(50),@makhach char(50),@ngayhoadon date,@ghichu nvarchar(100)
as
begin
	insert hoadon(mahd,makhach,ngayhoadon,ghichu) values
	(@mahd,@makhach,@ngayhoadon,@ghichu)
end

create proc proc_add_cthd @mahd char(50),@mahang char(50),@soluong int as
begin
	insert cthd(mahd,mahang,soluong) values
	(@mahd,@mahang,@soluong)
end




create proc proc_upd_hang @mahang char(50),@tenhang nvarchar(50),@dongia float,@ghichu nvarchar(100)
as
begin
	update hang set tenhang = @tenhang,
	dongia = @dongia,
	ghichu = @ghichu
	where mahang = @mahang
end

create proc proc_upd_khach @makhach char(50),@tenkhach nvarchar(50),@diachi nvarchar(100)
as
begin
	update khachhang set tenkhach = @tenkhach,diachi = @diachi
	where makhach = @makhach
end

create proc proc_upd_hoadon @mahd char(50),@makhach char(50),@ngayhoadon date,@ghichu nvarchar(100)
as
begin
	update hoadon set makhach = @makhach,ngayhoadon = @ngayhoadon ,ghichu = @ghichu
	where mahd = @mahd
end

create proc proc_upd_cthd @mahd char(50),@mahang char(50),@soluong int as
begin
	update cthd set soluong = @soluong 
	where mahang = @mahang and mahd=@mahd
end


create proc proc_del_hang @mahang char(50)
as
begin
	delete from cthd where mahang = @mahang
	delete from hang where mahang = @mahang
end

create proc proc_del_khach @makhach char(50)
as
begin
	delete from hoadon where makhach = @makhach
	delete from khachhang where makhach = @makhach
end

create proc proc_del_hoadon @mahd char(50),@makhach char(50)
as
begin
	delete from cthd where mahang = @mahd
	delete from hoadon where mahd = @mahd
end

create proc proc_del_cthd @mahd char(50) as
begin
	delete from cthd where mahd = @mahd
end

