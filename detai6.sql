create database qlsv_k20
use qlsv_k20

create table lop_k20
(malop char(50) primary key,
tenlop nvarchar(50),
gvcn nvarchar(50))

drop table lop_k20

create table sinhvien_k20
(masv char(50) primary key,
hosv nvarchar(50),
tensv nvarchar(50),
phai nvarchar(50) check (phai between N'Nam' and N'Nữ'),
ngaysinh date,
diachi nvarchar(100),
dienthoai char(50),
malop char(50),
constraint fk_sv_lop foreign key (malop) references lop_k20(malop))

create table ketqua_k20
(masv char(50),
mamh char(50),
diemlan1 float,
diemlan2 float,
constraint pk_kq primary key (masv,mamh),
constraint fk_kq_sv foreign key (masv) references sinhvien_k20(masv),
constraint fk_kq_mh foreign key (mamh) references monhoc_k20(mamh))

create table monhoc_k20
(mamh char(50) primary key,
tenmh nvarchar(50),
sotc int)

set dateformat dmy

select * from lop_k20

select * from sinhvien_k20
select * from monhoc_k20
select * from ketqua_k20

create proc themsinhvien @masv char(50),@hosv nvarchar(50),@tensv nvarchar(50),@phai nvarchar(50),@ngaysinh date,@diachi nvarchar(100),@dienthoai char(50),
@malop char(50) as
begin
	insert sinhvien_k20(masv,hosv,tensv,phai,ngaysinh,diachi,dienthoai,malop) values
	(@masv,@hosv,@tensv,@phai,@ngaysinh,@diachi,@dienthoai,@malop)
end

create proc themlophoc @malop char(50),@tenlop nvarchar(50),@gvcn nvarchar(50) as
begin
	insert lop_k20(malop,tenlop,gvcn) values (@malop,@tenlop,@gvcn)
end

create proc themmonhoc @mamh char(50),@tenmh nvarchar(50),@sotc int as
begin
	insert monhoc_k20(mamh,tenmh,sotc) values (@mamh,@tenmh,@sotc)
end

create proc themketqua @masv char(50),@mamh char(50),@diemlan1 float,@diemlan2 float as
begin
	insert ketqua_k20(masv,mamh,diemlan1,diemlan2) values
	(@masv,@mamh,@diemlan1,@diemlan2)
end


create proc suasinhvien @masv char(50),@hosv nvarchar(50),@tensv nvarchar(50),@phai nvarchar(50),@ngaysinh date,@diachi nvarchar(100),@dienthoai char(50),
@malop char(50) as
begin
	update sinhvien_k20 set hosv = @hosv,tensv = @tensv,phai = @phai,ngaysinh = @ngaysinh,diachi = @diachi,dienthoai = @dienthoai,malop = @malop
	where masv = @masv
end

create proc sualophoc @malop char(50),@tenlop nvarchar(50),@gvcn nvarchar(50) as
begin
	update lop_k20 set tenlop =@tenlop,gvcn = @gvcn
	where malop = @malop
end

create proc suamonhoc @mamh char(50),@tenmh nvarchar(50),@sotc int as
begin
	update monhoc_k20 set tenmh = @tenmh,sotc = @sotc
	where mamh = @mamh
end

create proc suaketqua @masv char(50),@mamh char(50),@diemlan1 float,@diemlan2 float as
begin
	update ketqua_k20 set diemlan1 = @diemlan1 ,diemlan2=@diemlan2
	where masv= @masv and mamh = @mamh
end

create proc xoasinhvien @masv char(50) as
begin
	delete from ketqua_k20 where masv = @masv
	delete from sinhvien_k20 where masv = @masv
end

create proc xoalophoc @malop char(50) as
begin
	update sinhvien_k20 set malop = null where malop = @malop
	delete from lop_k20 where malop = @malop
end

create proc xoamonhoc @mamh char(50) as
begin
	delete from ketqua_k20 where mamh = @mamh
	delete from monhoc_k20 where mamh = @mamh
end

create proc xoaketqua @masv char(50),@mamh char(50) as
begin
	delete from ketqua_k20 where masv = @masv and mamh = @mamh
end

create proc timkiemmasv1 @masv char(50) as
begin
	Select * from sinhvien_k20 where masv like CONCAT(rtrim(@masv),'%') or masv like CONCAT('%',rtrim(@masv)) or masv like CONCAT('%',rtrim(@masv),'%')
end

drop proc timkiemmasv1
insert into lop_k20(malop,tenlop,gvcn) values
('it1','Cntt',N'Giang')

insert into sinhvien_k20(masv,hosv,tensv,phai,ngaysinh,diachi,dienthoai,malop) values
('sv01',N'Nguyễn',N'Anh',N'Nam','12/03/2002',N'Vĩnh phúc','035265152','it1'),
('sv02',N'Nguyễn',N'Bình',N'Nam','12/03/2002',N'Vĩnh phúc','035265152','it1'),
('sv03',N'Nguyễn',N'Cường',N'Nam','12/03/2002',N'Vĩnh phúc','035265152','it1')

exec timkiemmasv1 '1'