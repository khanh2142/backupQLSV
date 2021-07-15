create database qlks
use qlks

create table nhanvien
(manv char(50) primary key,
tennv nvarchar(50),
ngaysinh date,
tendn char(50),
mk char(50))

create table phong 
(maphong char(50) primary key,
tang int,
loaiphong nvarchar(50),
mota nvarchar(100),
gia float,
tinhtrang nvarchar(100))

drop table hoadon_ks

create table hoadon_ks
(mahd char(50),
matp char(50) primary key,
ten nvarchar(50),
cmnd char(50),
ngaytra date,
tien float,
httt nvarchar(50),
constraint fk_hoadon_dstp foreign key (matp) references danhsachthuephong(matp))

create table danhsachthuephong
(matp char(50) primary key,
maphong char(50),
cmnd char(50),
tenkhach nvarchar(50),
songuoi int,
ngaynhan date,
datornhan nvarchar(50),
constraint fk_dstp_phong foreign key (maphong) references phong(maphong))


set dateformat ydm

select * from test
select * from nhanvien
select * from phong
select * from thuephong
select * from hoadon_ks

exec proc_add_thuephong 'ks01','phong01','123456',N'Long',2,'2021/5/5','D'
exec proc_add_nhanvien 'nv01',N'Mạnh','2021/5/18','manh01','mmm'
exec proc_upd_phong 'phong01',4,N'Vip','fasd',555555,N'Còn'
exec proc_add_phong 'phong02',4,N'Vip','fasd',555555,N'Còn'
exec proc_add_phong 'phong03',4,N'Vip','fasd',555555,N'Còn'



create proc proc_add_nhanvien @manv char(50),@tennv nvarchar(50),@ngaysinh date,@tendn char(50),@mk char(50)
as
begin
	insert nhanvien(manv,tennv,ngaysinh,tendn,mk) values
	(@manv,@tennv,@ngaysinh,@tendn,@mk)
end

create proc proc_add_thuephong @matp char(50),@maphong char(50),@cmnd char(50),@tenkh nvarchar(50),@songuoi int,@ngaynhan date,@datornhan nvarchar(50)
as
begin
	insert thuephong(matp,maphong,cmnd,tenkh,songuoi,ngaynhan,datornhan) values
	(@matp,@maphong,@cmnd,@tenkh,@songuoi,@ngaynhan,@datornhan)
end

create proc proc_add_phong @maphong char(50),@tang int,@loaiphong nvarchar(50),@mota nvarchar(100),@gia float,@tinhtrang nvarchar(50)
as
begin
	insert phong(maphong,tang,loaiphong,mota,gia,tinhtrang) values
	(@maphong,@tang,@loaiphong,@mota,@gia,@tinhtrang)
end

create proc proc_add_hoadon @mahd char(50),@matp char(50),@ten nvarchar(50),@cmnd char(50),@ngaytra date,@tien float,@httt nvarchar(50)
as
begin
	insert hoadon_ks(mahd,matp,ten,cmnd,ngaytra,tien,httt) values
	(@mahd,@matp,@ten,@cmnd,@ngaytra,@tien,@httt)
end

create proc proc_upd_nhanvien @manv char(50),@tennv nvarchar(50),@ngaysinh date,@tendn char(50),@mk char(50)
as
begin
	update nhanvien set tennv = @tennv,ngaysinh = @ngaysinh,tendn = @tendn,mk = @mk
	where manv = @manv
end

create proc proc_upd_thuephong @matp char(50),@maphong char(50),@cmnd char(50),@tenkh nvarchar(50),@songuoi int,@ngaynhan date,@datornhan nvarchar(50)
as
begin
	update thuephong set maphong = @maphong,cmnd = @cmnd , tenkh = @tenkh ,songuoi = @songuoi,@ngaynhan = @ngaynhan,datornhan = @datornhan
	where matp = @matp
end

create proc proc_upd_phong @maphong char(50),@tang int,@loaiphong nvarchar(50),@mota nvarchar(100),@gia float,@tinhtrang nvarchar(50)
as
begin
	update phong set tang = @tang,loaiphong = @loaiphong,mota = @mota , gia = @gia,tinhtrang = @tinhtrang 
	where maphong = @maphong
end

create proc proc_upd_hoadon @mahd char(50),@matp char(50),@ten nvarchar(50),@cmnd char(50),@ngaytra date,@tien float,@httt nvarchar(50)
as
begin
	update hoadon_ks set ten = @ten,cmnd = @cmnd,ngaytra = @ngaytra,tien = @tien,httt = @httt
	where mahd = @mahd and matp = @matp
end


create proc proc_del_nhanvien @manv char(50) as
begin
	delete from nhanvien where manv = @manv
end

create proc proc_del_thuephong @matp char(50) as
begin
	delete from hoadon_ks where matp = @matp
	delete from thuephong where matp = @matp
end

create proc proc_del_phong @maphong char(50) as
begin
	update thuephong set maphong = null where maphong = @maphong
	delete from phong where maphong = @maphong
end

create proc proc_del_hoadon @mahd char(50)
as
begin
	delete from hoadon_ks where mahd = @mahd
end

create proc themthuephong 
@mathuephong char(50),
@maphong char(50),
@chungminhnhandan char(50),
@tenkhach nvarchar(50),
@songuoi int,
@ngaynhan date,
@don nvarchar(50)
as
begin
	insert danhsachthuephong(matp,maphong,cmnd,tenkhach,songuoi,ngaynhan,datornhan)
	values
	(@mathuephong,@maphong,@chungminhnhandan,@tenkhach,@songuoi,@ngaynhan,@don)
end


drop proc themthuephong

exec themthuephong 'ks01','phong01','4541548',N'Giang',3,'2021/5/5',N'Đặt'
exec themthuephong 'ks02','phong02','4541122',N'Linh',2,'2021/6/6',N'Đặt'
exec themthuephong 'thue03','phong03','1215452',N'Dung',1,'2021/7/7',N'Đặt'

select * from danhsachthuephong

create proc suathuephong 
@mathuephong char(50),
@maphong char(50),
@chungminhnhandan char(50),
@tenkhach nvarchar(50),
@songuoi int,
@ngaynhan date,
@don nvarchar(50)
as
begin
	update danhsachthuephong set maphong = @maphong,
	cmnd = @chungminhnhandan,
	tenkhach = @tenkhach,
	songuoi = @songuoi,
	ngaynhan = @ngaynhan,
	datornhan = @don
	where matp = @mathuephong
end

create proc xoathuephong 
@mathuephong char(50)
as
begin
	delete from danhsachthuephong where matp = @mathuephong
end

exec proc_add_nhanvien 'nv01',N'Nguyễn Văn Long','2000/5/5','long01','123456'
exec proc_add_nhanvien 'nv02',N'Trần Hải Minh','2000/5/15','minh01','1234576'
exec proc_add_nhanvien 'nv03',N'Lương Hải Châu','2000/2/1','chaulong01','xxx333'
exec proc_add_nhanvien 'nv04',N'Đặng Quang Bình','2000/3/4','binhphuong02','xxxReact'
exec proc_add_nhanvien 'nv05',N'Lê Thị Huyền','2000/6/9','huyen12123','1545212'

exec proc_add_hoadon 'hd01','thue03',N'Dung','41541515','2021/5/25',500000,'Visa'
exec proc_add_hoadon 'hd02','ks01',N'Dung','41536515','2021/6/30',300000,'Visa'
exec proc_add_hoadon 'hd03','thue01',N'Dung','1215515','2021/4/1',451000,'Visa'

select * from hoadon_ks