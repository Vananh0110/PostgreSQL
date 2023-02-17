-- Câu 1: Đưa ra danh sách mặt hàng (MaHang, Ten) thuộc danh mục "Phụ kiện"
select Ma_hang, Ten, Thuong_hieu
from MatHang where Danh_muc = 'Phụ kiện';

-- Câu 2: Đưa ra danh sách các sản phẩm của thương hiệu "Uniqlo"
select distinct Ten
from Mathang where Thuong_hieu = 'Uniqlo';

-- Câu 3: Đưa ra danh sách các sản phẩm thuộc danh mục "Túi xách" của thương hiệu "Chanel" và sắp xếp theo giá tiền bán ra
select Ma_hang, Ten, Gia_ban
from MatHang where Danh_muc = 'Túi xách' and Thuong_hieu = 'Chanel'
order by Gia_ban ASC;

-- Câu 4: Đưa ra danh sách số lượng mặt hàng của các thương hiệu và sắp xếp theo thứ tự alphabet theo tên các thuơng hiệu
select Thuong_hieu, count(Ma_hang)
from MatHang
group by Thuong_hieu
order by Thuong_hieu ASC

-- Câu 5: Đưa ra danh sách các sản phẩm mà trong tên có chứa "Túi" và giá lớn hơn 300 $
select *
from MatHang
where Danh_muc ilike '%Túi%' and Gia_ban > 300

-- Câu 6: Đưa ra danh sách khách hàng nữ
select *
from Users
where Gioi_tinh = 'F';

-- Câu 7: Đưa ra danh sách các khách hàng nam đã mua mặt hàng "Quần bò"
select u.UserID, u.Ho_va_ten, u.Ngay_sinh, u.Sdt, u.Dia_chi
from Users u join Don_hang using (UserID) join Thong_tin_don_hang using (Ma_don) join MatHang m using (Ma_hang)
where m.Ten = 'Quần bò' and u.Gioi_tinh = 'M'
group by u.UserID;


-- Cách 2:
create or replace function Khachhang_gt_ten (Gt character, t character varying)
returns table (UserID character, Ho_va_ten character varying, Ngay_sinh date, Sdt character varying, Dia_chi Character varying)
as
$$
begin
	return query select u.UserID, u.Ho_va_ten, u.Ngay_sinh, u.Sdt, u.Dia_chi
	from Users u join Don_hang using (UserID) join Thong_tin_don_hang using (Ma_don) join MatHang m using (Ma_hang)
	where m.Ten = t and u.Gioi_tinh = Gt
	group by u.UserID;
end
$$
language plpgsql;
select * from Khachhang_gt_ten('M', 'Quần bò');

-- Câu 8: Hiển thị ra số tiền (Thanh_tien) lớn nhất, nhỏ nhất, trung bình trong đơn hàng

select max(Thanh_tien) as Tien_max, min(Thanh_tien) as Tien_min, avg (Thanh_tien) as Tien_avg
from Thong_tin_don_hang;

-- Câu 9: Hiển thị danh sách các mặt hàng, số lượng nhập được nhập vào kho trong tháng 5/2022
create index idx_kho_chua
on Kho_chua(Ngay_nhap_hang);

select m.Ma_hang, m.Ten, k.So_luong_nhap
from Kho_chua k join MatHang m using (Ma_hang)
where date_part('month', k.Ngay_nhap_hang) = 5 and date_part('year', k.Ngay_nhap_hang) = 2022;

-- Câu 10: Đưa ra danh sách các mặt hàng có giá bán trên 1000
select *
from MatHang where Gia_ban > 1000;

-- Câu 11: Đưa ra danh sách các khách hàng từ 30 tuổi trở lên
select * from Users where date_part('year',(age(current_date,Ngay_sinh))) >= 30;

-- Câu 12: Đưa ra danh sách những đơn hàng bị hủy trong tháng 2 – 2022
select m.Ma_hang, m.Ten, m.Danh_muc, m.Thuong_hieu
from MatHang m join Thong_tin_don_hang t using (Ma_hang) join Don_hang d using (Ma_don)
where d.Tinh_trang_don = 'Bị hủy'
and date_part('month', d.Ngay_dat_hang) = 2
and date_part('year', d.Ngay_dat_hang) = 2022;

-- Câu 13: Đưa ra danh sách UserID, tên của những khách hàng đã hủy đơn ít nhất 1 lần.
select u.UserID, u.Ho_va_ten
from Users u join Don_hang d using (UserID)
where d.Tinh_trang_don = 'Bị hủy'
group by u.UserID
having count(u.UserID) >= 1;

-- Câu 14: Tìm người lớn tuổi nhất mua túi xách vào tháng 8-2021


-- Câu 15: Tìm những người đã mua thành công mặt hàng thuộc danh mục "Quần áo" và thanh toán "Online"
select u.UserID, u.Ho_va_ten, u.Sdt, u.Ngay_sinh, u.Dia_chi, u.Gioi_tinh
from Users u join Don_hang d using (UserID)
join Thong_tin_don_hang t using (Ma_don)
join MatHang m using (Ma_hang)
where m.Danh_muc = 'Quần áo'
and d.Tinh_trang_don = 'Giao hàng thành công'
and d.Hinh_thuc_thanh_toan = 'Online';

-- Câu 16: Liệt kê những đơn hàng có số tiền vượt quá 2000
select d.Ma_don, Ngay_dat_hang, So_luong, So_luong * Gia_ban as Tong_hoa_don
from MatHang m, Don_hang d, Thong_tin_don_hang t
where m.Ma_hang = t.Ma_hang
	and d.Ma_don = t.Ma_don
	and So_luong * Gia_ban > 2000;

-- Câu 17: Đưa ra thông tin chi tiết về mặt hàng trong hóa đơn có mã đơn là "MD10"
-- Cách 1:
select m.Ma_hang, m.Ten, m.Danh_muc, m.Thuong_hieu, m.Gia_ban
from MatHang m join Thong_tin_don_hang t using (Ma_hang) join Don_hang d using (Ma_don)
where d.Ma_don = 'MD10';
--  Cách 2:
create or replace function f_ct_mh_hd(madon character)
returns table (Ma_hang character, Ten character varying, Danh_muc character varying, Thuong_hieu character varying) as
$$
begin
	return query select m.Ma_hang, m.Ten, m.Danh_muc, m.Thuong_hieu
	from MatHang m join Thong_tin_don_hang t using (Ma_hang)
	join Don_hang d using (Ma_don)
	where d.Ma_don = madon;
end
$$
language plpgsql;
select * from f_ct_mh_hd('MD10');
-- Câu 18: Đưa ra tên các mặt hàng không có người mua trong tháng 12/2020
select Ma_hang, Ten, Danh_muc, Thuong_hieu
from MatHang where Ma_hang
not in
(select Ma_hang
from Thong_tin_don_hang t join Don_hang d using (Ma_don)
where date_part('month', Ngay_dat_hang) = 12
and date_part('year', Ngay_dat_hang) = 2020);

-- Câu 19: Đưa ra danh sách sắp xếp các mặt hàng theo lợi nhuận thu được đơn giá từ cao đến thấp.
select Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_ban, (Gia_ban - Gia_nhap_vao) as Loi_nhuan
from MatHang
order by (Gia_ban - Gia_nhap_vao) DESC;

-- Câu 20: Liệt kê các khách hàng có đơn hàng có mã đơn bắt đầu bằng "M"
select u.UserID, u.Ho_va_ten, u.Ngay_sinh, u.Gioi_tinh
from Users u join Don_hang d using (UserID)
where d.Ma_don like 'M%';
-- Câu 21: Đếm số mặt hàng ở mỗi kho
select Ma_kho, count(Ma_hang) as So_mat_hang
from Kho_chua
group by Ma_kho;

-- Câu 22: Liệt kê những người họ "Trần" và "Ngô" mua quần áo
create index idx_danh_muc on MatHang(Danh_muc);
select u.UserID, u.Ho_va_ten, u.Ngay_sinh, u.Gioi_tinh
from Users u join Don_hang d using (UserID) join Thong_tin_don_hang t using (Ma_don) join MatHang m using (Ma_hang)
where m.Danh_muc = 'Quần áo' and (u.Ho_va_ten like '%Trần%' or u.Ho_va_ten like '%Ngô%');

-- Câu 23: Danh sách các sản phẩm được mua và số lượng mua trong Quý 2 năm 2021
select Ma_hang,Sum(So_luong)
from Thong_tin_don_hang ,Don_hang 
where (Ngay_dat_hang between '2021-04-01' and '2021-06-30') 
group by Ma_hang;

-- Câu 24: Đưa ra danh sách UserID, tên của những khách hàng chưa hủy đơn lần nào
select u.UserID, u.Ho_va_ten
from Users u join Don_hang d using (UserID)
where d.Tinh_trang_don not in
(select Tinh_trang_don
from Don_hang where Tinh_trang_don = 'Bị hủy')

-- Câu 25: Đưa ra danh sách những khách hàng nữ có địa chỉ ở Hà Nội
select *
from Users
where Gioi_tinh = 'F' and Dia_chi like '%Hà Nội%';

-- Câu 26: Đưa ra mặt hàng bán chạy nhất trong tháng 11/2022
select t.ma_hang, count(t.ma_hang) as num into newtable3
from thong_tin_don_hang t join don_hang d using(ma_don)
where d.tinh_trang_don = 'Giao hàng thành công'
    and d.ngay_dat_hang between '2022-12-01' and '2022-12-31'
group by t.ma_hang;

select n.ma_hang, m.ten, m.danh_muc, m.thuong_hieu, n.num from newtable3 n join mathang m using(ma_hang)
where num = (select max(num) from newtable3);

-- Câu 27: Đưa ra mặt hàng được nhập về nhiều nhất
select Ma_hang, sum(So_luong_nhap) as num into newtable5
from Kho_chua
group by Ma_hang;
select m.Ma_hang, m.Ten, m.Danh_muc, m.Thuong_hieu
from MatHang m join newtable5 n using (Ma_hang)
where n.num = (select max(num) from newtable4);

-- Câu 28: Tìm danh mục có số lượng mặt hàng được mua nhiều nhất trong năm 2021
select m.Danh_muc, count(m.Ma_hang) as num into newtable1
from MatHang m join Thong_tin_don_hang using (Ma_hang) join Don_hang d using (Ma_don) where date_part('year', d.Ngay_dat_hang) = 2021
and d.Tinh_trang_don = 'Đã giao hàng thành công'
group by m.Danh_muc;
select Danh_muc, num from newtable1 where num = (select max(num) from newtable1);

-- Câu 29: Đưa ra lịch sử nhập mặt hàng quần bò của thương hiệu Gucci trong năm 2021
select k.Ngay_nhap_hang, k.So_luong_nhap
from Kho_chua k join MatHang m using (Ma_hang)
where m.Ten = 'Quần bò' and m.Thuong_hieu = 'Gucci' and date_part('year', k.Ngay_nhap_hang) = 2021;

-- Câu 30: Tìm khách hàng mua nhiều nhất (nhiều hóa đơn nhất)
select u.UserID, u.Ho_va_ten, u.Ngay_sinh, u.Gioi_tinh, count (d.Ma_don) as num into newtable2
from Users u join Don_hang d using (UserID)
group by u.UserID;
select u.UserID, u.Ho_va_ten, u.Ngay_sinh, u.Gioi_tinh from newtable2 where num = (select max(num) from newtable2);




