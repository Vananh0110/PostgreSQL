DROP DATABASE IF EXISTS projectcuoiki;
CREATE DATABASE projectcuoiki;
\c projectcuoiki
-- Users (UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh)
-- MatHang (Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban)
-- Kho (Ma_kho, Ngay_nhap_hang)
-- Kho_chua (Ma_kho, Ma_hang, So_luong_nhap, So_luong_con_lai)
-- Don_hang (Ma_don, Ngay_dat_hang, Tinh_trang_don, Hinh_thuc_thanh_toan, UserID)
-- Thong_tin_don_hang (Ma_don, Ma_hang, So_luong, Thanh_tien)

CREATE TABLE Users(
    UserID character(10) NOT NULL,
    Ho_va_ten character varying(50) NOT NULL,
    Sdt character varying (50) NOT NULL,
    Ngay_sinh date NOT NULL,
    Dia_chi character varying(100) NOT NULL,
    Gioi_tinh character (1) NOT NULL,
    CONSTRAINT PK_Users PRIMARY KEY (UserID),
    CONSTRAINT users_chk_gt CHECK (Gioi_tinh = 'F' OR Gioi_tinh = 'M')tuy
);

CREATE TABLE MatHang(
    Ma_hang character(10) NOT NULL,
    Ten character varying NOT NULL,
    Danh_muc character varying NOT NULL,
    Thuong_hieu character varying NOT NULL,
    Gia_nhap_vao integer NOT NULL,
    Gia_ban integer NOT NULL,
    CONSTRAINT PK_MaHang PRIMARY KEY (Ma_hang)
);

CREATE TABLE Kho(
    Ma_kho character (10) NOT NULL,
    So_luong_toi_da integer NOT NULL,
    So_luong_thuc_te integer NOT NULL,
    So_luong_con_trong integer,
    CONSTRAINT PK_Kho PRIMARY KEY (Ma_kho)
);

CREATE TABLE Kho_chua(
    Ma_kho character(10) NOT NULL,
    Ma_hang character(10) NOT NULL,
    So_luong_nhap integer NOT NULL,
    Ngay_nhap_hang date NOT NULL,
    FOREIGN KEY (Ma_Kho) REFERENCES Kho(Ma_kho),
    FOREIGN KEY (Ma_hang) REFERENCES MatHang(Ma_hang)
);

CREATE TABLE Don_hang(
    Ma_don character(10) NOT NULL,
    Tinh_trang_don character varying (50) NOT NULL,
    Hinh_thuc_thanh_toan character varying (50) NOT NULL,
    Ngay_dat_hang date NOT NULL,
    UserID character(10) NOT NULL,
    CONSTRAINT PK_don_hang PRIMARY KEY (Ma_don),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Thong_tin_don_hang(
    Ma_don character(10) NOT NULL,
    Ma_hang character(10) NOT NULL,
    So_luong integer NOT NULL,
    Thanh_tien integer,
    PRIMARY KEY (Ma_don, Ma_hang),
    FOREIGN KEY (Ma_don) REFERENCES Don_hang(Ma_don),
    FOREIGN KEY (Ma_hang) REFERENCES MatHang(Ma_hang)
);

CREATE OR REPLACE FUNCTION afup_real_quan() RETURNS TRIGGER
AS
$$
BEGIN
	update Kho set So_luong_con_trong = So_luong_toi_da - So_luong_thuc_te
    where NEW.Ma_kho = Kho.Ma_kho;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER afup_real_quan
AFTER INSERT ON Kho
FOR EACH ROW
EXECUTE PROCEDURE afup_real_quan();

\encoding 'utf8'
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('1', 'Phạm Vân Anh', '097834567', '2002-10-01','Phú Châu, Đông Hưng, Thái Bình', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('2', 'Hoàng Thế Anh', '097833421', '2002-10-04','Phú Châu, Đông Hưng, Bắc Giang', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('3', 'Nguyễn Đức Anh', '0978239833', '2002-09-01','Hòa Lạc, Đông Hưng, Thái Bình', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('4', 'Nguyễn Vân Anh', '0978349846', '2000-10-01','Phú Châu, Đông Hưng, Ha Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('5', 'Phạm Vân Ánh', '097823219', '2001-04-01','Phú Châu, Duy Tiên, Lào Cai', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('6', 'Phạm Vân An', '097346787', '2003-09-02','Phú Châu, Thanh Liêm, Nam Định', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('7', 'Phạm Thiên An', '097238965', '2001-04-28','Liêm Tuyền, Đông Hưng, Bắc Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('8', 'Phạm Xuân Duy', '097234565', '2001-05-23','Liêm Tuyền, Đông Hưng, Hải Dương', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('9', 'Phạm Thuận', '095432965', '2000-07-18','Lục Ngạn, Hiệp Hòa, Hà Tây', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('10', 'Nguyễn Đức Hoàng', '097234532', '2001-04-28','Thanh Liêm, Duy Tiên, Bắc Ninh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('11', 'Phạm Hữu Thái', '097345125', '2000-03-08','Liêm Chính, Đông Mai, Ninh Bình', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('12', 'Phạm Tuấn Nam', '097232156', '2001-04-21','Liêm Thuận, Kim Bảng, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('13', 'Ngô Kiến Huy', '092134532', '1999-05-01','Liêm Tuyền, Đông Hưng, hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('14', 'Phạm Thiên Tuấn', '097234215', '2001-10-31','Bắc Tuyền, Đông Bắc, Bắc Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('15', 'Nguyễn Thiên An', '097232365', '2001-01-24','Liêm Hương, Hòa Hưng, Ninh Thuận', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('16', 'Phạm Thiên Phúc', '0972123165', '2000-04-28','Thanh Hương, Đông Hưng, Thanh Hóa', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('17', 'Phạm Nhật Vượng', '097123165', '2001-08-08','Liêm Tuyền, Phủ Lý, hà Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('18', 'Phạm Tiến Lộc', '097123265', '2004-04-28','Liêm Cần, Đông Chúc, Lào Cai', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('19', 'Phạm Xuân An', '0973412235', '2001-06-25','Lục Ngạn, Hiệp Hòa, Bắc Giang', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('20', 'Ngô Bảo Châu', '097221345', '1993-03-28','Liêm Túc, Đông Hưng, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('21', 'Nguyễn Duy Tuấn', '0972311223', '2000-04-12','Liêm Thanh, Đông Nam, Bắc Ninh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('22', 'Nguyễn Duy Phong', '0972341223', '2001-03-12','Liêm Túc, Đông Hưng, Bắc Ninh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('23', 'Nguyễn Duy Nam', '0972342323', '2001-05-04','Liêm Tranh, Đông Bắc, Bắc Giang', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('24', 'Nguyễn Duy Hoàng', '0972321223', '2001-05-04','Liêm Tanh, Đông Mai, Bắc Cạnh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('25', 'Nguyễn Duy Khánh', '097257223', '2001-06-30','Liêm Tanh, Đông Tây, Bắc Giang', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('26', 'Nguyễn Duy Long', '09724554223', '2001-03-04','Liêm Tanh, Đông Hợi, Bắc Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('27', 'Nguyễn Duy Anh', '0973425773', '2001-02-09','Liêm Tanh, Đông Hắc, Bắc Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('28', 'Nguyễn Duy Bắc', '0972345464', '2001-02-03','Liêm Tanh, Nam Hưng, Bắc Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('29', 'Nguyễn Duy Đông', '09723454634', '2001-02-04','Liêm Tanh, Đông Hưng, Bắc Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('30', 'Nguyễn Duy Tây', '097235678', '2001-02-11','Liêm Tanh, Tây Hưng, Bắc Ninh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('31', 'Nguyễn Duy Hà', '0972435634', '2001-02-12','Liêm Tanh, Mai Hưng, Bắc Ninh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('32', 'Lê Thế Hà', '097232442321', '1998-02-12','Thanh Liêm, Thanh Hương, Hà Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('33', 'Lê Thế Hoàng', '0972323141', '1998-04-12','Thanh Liêm, Thanh Mai, Hà Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('34', 'Lê Thế Nam', '097234425', '1998-05-12','Thanh Liêm, Thanh Hương, Hà Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('35', 'Lê Thế Hà', '0972327781', '1998-06-12','Thanh Liêm, Thanh Hương, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('36', 'Lê Thế Hà', '0972325651', '1998-07-12','Thanh Hải, Thanh Hương, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('37', 'Lê Thế Hà', '0972367881', '1998-08-12','Thanh Loan, Thanh Giang, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('38', 'Lê Thế Hà', '0972356858', '1998-09-12','Thanh Nghị, Thanh Tuyết, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('39', 'Lê Thế Hà', '0972365788', '1998-10-10','Thanh Chúc, Thanh Xú, Hà Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('40', 'Lê Thế Hà', '0972324241', '1998-11-12','Thanh Khê, Thanh Hương, Hà Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('41', 'Đặng Thị Nhung', '0972324345', '1985-11-01','Lục Cần, Đồng Tâm, Hồ Chí Minh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('42', 'Đặng Thị Thuyết', '0972323577', '1985-01-01','Lục Cần, Đồng Nam, Hồ Hoàn Kiếm', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('43', 'Đặng Thị Mai', '0972345678', '1985-12-01','Lục Cần, Đồng Bắc, Hồ Ba Vì', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('44', 'Đặng Thị Nhun', '0972321345', '1985-04-01','Lục Cần, Đồng Tây, Hồ Một Cột', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('45', 'Đặng Thị Như', '0456784345', '1985-04-01','Lục Cần, Đồng Dồng, Hồ Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('46', 'Đặng Thị Mai', '0967544345', '1985-11-01','Lục Cần, Đồng Nát Hồ Bắc Minh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('47', 'Đặng Thị Tuyết', '0345674345', '1985-12-01','Lục Cần, Đồng Cô, Hồ Anh Minh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('48', 'Đặng Thị Bích', '0976544345', '1985-04-01','Lục Cần, Đồng Đô, Hồ Sơn Minh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('49', 'Đặng Thị Ngọc', '0912344345', '1985-04-01','Lục Cần, Đồng Tâm, Hồ Cửu Minh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('50', 'Đặng Thị Kim', '0956784345', '1985-05-01','Lục Cần, Đồng Mai, Hồ Tám Minh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('51', 'Hoàng Hồng Nhung', '095324245', '1982-01-01','Phù Lý, Hà Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('52', 'Hoàng Hồng Mai', '095334245', '1982-02-02','Phù Lý, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('53', 'Hoàng Hồng Đông', '095677545', '1982-03-01','Phù Lý, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('54', 'Hoàng Hồng Cung', '097556545', '1982-04-04','Phù Lý, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('55', 'Hoàng Hồng Hoa', '097564545', '1982-05-05','Phù Lý, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('56', 'Hoàng Hồng Tuyết', '098755645', '1982-05-06','Phù Lý, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('57', 'Hoàng Hồng Mai', '093435645', '1982-06-08','Phù Lý, Hà Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('58', 'Hoàng Hồng Bích', '093356645', '1982-07-06','Phù Lý, Hà Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('59', 'Hoàng Hồng Oanh', '095456445', '1982-08-09','Phù Lý, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('60', 'Ngô Kiến Giang', '095434225', '1992-08-09','121 Lê Thanh Nghị, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('61', 'Ngô Kiến Giang', '095232125', '1992-04-04','123 Lê Thanh Nghị, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('62', 'Ngô Kiến Giang', '095453325', '1992-03-05','124 Lê Thanh Nghị, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('63', 'Ngô Kiến Giang', '095445325', '1992-05-06','125 Lê Thanh Nghị, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('64', 'Ngô Kiến Giang', '095342425', '1992-06-09','155 Lê Thanh Nghị, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('65', 'Ngô Kiến Giang', '095454335', '1992-07-03','161 Lê Thanh Nghị, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('66', 'Ngô Kiến Giang', '095423125', '1992-02-03','171 Lê Thanh Nghị, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('67', 'Ngô Kiến Giang', '095342325', '1992-01-09','181 Lê Thanh Nghị, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('68', 'Ngô Kiến Giang', '095452425', '1992-03-08','121 Lê Thanh Nghị, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('69', 'Ngô Kiến Giang', '095412325', '1992-04-02','131 Lê Thanh Nghị, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('70', 'Nguyễn Văn Nam', '095234325', '1982-01-12','113 Bạch Mai, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('71', 'Nguyễn Văn Bắc', '095231325', '1982-03-14','112 Bạch Mai, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('72', 'Nguyễn Văn Đông', '023144325', '1982-03-15','113 Bạch Mai, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('73', 'Nguyễn Văn Tây', '092314325', '1982-04-16','115 Bạch Mai, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('74', 'Nguyễn Văn Kinh', '056445325', '1982-05-18','115 Bạch Mai, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('75', 'Nguyễn Văn Bảo ', '096466325', '1982-06-18','116 Bạch Mai, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('76', 'Nguyễn Văn Đông', '095234343', '1982-07-12','117 Bạch Mai, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('77', 'Nguyễn Văn Cửu', '095235332', '1982-08-13','151 Bạch Mai, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('78', 'Nguyễn Văn Mai', '095242675', '1982-09-12','141 Bạch Mai, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('79', 'Nguyễn Văn Võ', '095236443', '1982-03-14','131 Bạch Mai, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('80', 'Trấn Thành', '0954334225', '1985-01-25','161 Trần Đại Nghĩa, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('81', 'Trấn Thành', '0952324225', '1985-02-21','31 Trần Đại Nghĩa, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('82', 'Trấn Thành', '0932244225', '1985-03-22','11 Trần Đại Nghĩa, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('83', 'Trấn Thành', '0954644225', '1985-04-23','16 Trần Đại Nghĩa, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('84', 'Trấn Thành', '0955434225', '1985-05-24','165 Trần Đại Nghĩa, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('85', 'Trấn Thành', '0923224225', '1985-06-26','178 Trần Đại Nghĩa, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('86', 'Trấn Thành', '0954434225', '1985-01-27','187 Trần Đại Nghĩa, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('87', 'Trấn Thành', '0954334225', '1985-07-28','196 Trần Đại Nghĩa, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('88', 'Trấn Thành', '0952424225', '1985-08-29','125 Trần Đại Nghĩa, Hà Nội', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('89', 'Trấn Thành', '0952434225', '1985-09-23','153 Trần Đại Nghĩa, Hà Nội', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('90', 'Trần Viết Quân', '0952342325', '1995-03-03','154 Lê Duẩn, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('91', 'Trần Viết Quân', '0952323225', '1995-04-04','155 Lê Duẩn, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('92', 'Trần Viết Quân', '0953464525', '1995-05-05','156 Lê Duẩn, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('93', 'Trần Viết Quân', '0956554425', '1995-06-04','157 Lê Duẩn, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('94', 'Trần Viết Quân', '0952556425', '1995-07-05','158 Lê Duẩn, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('95', 'Trần Viết Quân', '0952564525', '1995-08-06','1 Lê Duẩn, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('96', 'Trần Viết Quân', '0952345625', '1995-09-07','653 Lê Duẩn, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('97', 'Trần Viết Quân', '0952756425', '1995-01-01','553 Lê Duẩn, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('98', 'Trần Viết Quân', '0952345625', '1995-02-02','553 Lê Duẩn, Hà Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('99', 'Trần Viết Quân', '0952453325', '1995-03-04','653 Lê Duẩn, Hà Nam', 'M');

-- Mat hang
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q11', 'Quần bò', 'Quần áo', 'Gucci', 145, 190);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q16', 'Quần bò', 'Quần áo', 'Calvin Klein', 200, 240);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q17', 'Quần bò', 'Quần áo', 'Uniqlo', 210, 230);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q18', 'Quần bò', 'Quần áo', 'D&G', 215, 250);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q22', 'Quần đùi', 'Quần áo', 'Chanel', 175, 200);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q23', 'Quần đùi', 'Quần áo', 'Adidas', 150, 190);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q24', 'Quần đùi', 'Quần áo', 'Nike', 200, 220);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q26', 'Quần đùi', 'Quần áo', 'Calvin Klein', 130, 180);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q27', 'Quần đùi', 'Quần áo', 'Uniqlo', 195, 210);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q28', 'Quần đùi', 'Quần áo', 'D&G', 140, 150);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q31', 'Quần âu', 'Quần áo', 'Gucci',225, 265);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q37', 'Quần âu', 'Quần áo', 'Uniqlo', 220, 270);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q38', 'Quần âu', 'Quần áo', 'D&G', 235, 260);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q42', 'Quần lót', 'Quần áo', 'Chanel', 85, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q43', 'Quần lót', 'Quần áo', 'Adidas', 100, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q44', 'Quần lót', 'Quần áo', 'Nike', 90, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q46', 'Quần lót', 'Quần áo', 'Kelvin Calvin', 80, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q48', 'Quần lót', 'Quần áo', 'D&G', 90, 105);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q51', 'Quần yếm', 'Quần áo', 'Gucci', 165, 180);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q55', 'Quần yếm', 'Quần áo', 'AAA', 145, 170);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q57', 'Quần yếm', 'Quần áo', 'Uniqlo', 150, 180);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V11', 'Váy bò', 'Quần áo', 'Gucci', 160, 175);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V12', 'Váy bò', 'Quần áo', 'Chanel', 150, 190);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V18', 'Váy bò', 'Quần áo', 'D&G', 100, 130);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V21', 'Váy dài', 'Quần áo', 'Gucci', 125, 145);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V25', 'Váy dài', 'Quần áo', 'AAA', 155, 165);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V26', 'Váy dài', 'Quần áo', 'Calvin Klein', 120, 150);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V34', 'Váy ngắn', 'Quần áo', 'Nike', 100, 125);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V37', 'Váy ngắn', 'Quần áo', 'Uniqlo', 90, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A12', 'Áo sơ mi', 'Quần áo', 'Chanel', 575, 600);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A17', 'Áo sơ mi', 'Quần áo', 'Uniqlo', 735, 750);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A18', 'Áo sơ mi', 'Quần áo', 'D&G', 800, 825);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A21', 'Áo khoác', 'Quần áo', 'Gucci', 875, 915);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A22', 'Áo khoác', 'Quần áo', 'Chanel', 920, 970);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A23', 'Áo khoác', 'Quần áo', 'Adidas', 850, 875);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A24', 'Áo khoác', 'Quần áo', 'Nike', 940, 955);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A25', 'Áo khoác', 'Quần áo', 'AAA', 895, 915);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A27', 'Áo khoác', 'Quần áo', 'Uniqlo', 800, 835);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A28', 'Áo khoác', 'Quần áo', 'D&G', 995, 1005);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A31', 'Áo phông', 'Quần áo', 'Gucci', 310, 325);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A32', 'Áo phông', 'Quần áo', 'Chanel', 275, 300);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A33', 'Áo phông', 'Quần áo', 'Adidas', 250, 295);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A34', 'Áo phông', 'Quần áo', 'Nike', 295, 315);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A36', 'Áo phông', 'Quần áo', 'Calvin Klein', 300, 325);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A37', 'Áo phông', 'Quần áo', 'Uniqlo', 350, 375);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A38', 'Áo phông', 'Quần áo', 'D&G', 310, 350);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A41', 'Áo croptop', 'Quần áo', 'Gucci', 70, 90);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A43', 'Áo croptop', 'Quần áo', 'Adidas', 70, 95);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A44', 'Áo croptop', 'Quần áo', 'Nike', 80, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A45', 'Áo croptop', 'Quần áo', 'AAA', 90, 105);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A48', 'Áo croptop', 'Quần áo', 'D&G', 95, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A54', 'Áo ba lỗ', 'Quần áo', 'Nike', 100, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A57', 'Áo ba lỗ', 'Quần áo', 'Uniqlo', 115, 130);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A58', 'Áo ba lỗ', 'Quần áo', 'D&G', 120, 150);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A62', 'Áo tắm', 'Quần áo', 'Chanel', 180, 200);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A63', 'Áo tắm', 'Quần áo', 'Chanel', 160, 210);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A66', 'Áo tắm', 'Quần áo', 'Calvin Klein', 170, 230);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A68', 'Áo tắm', 'Quần áo', 'D&G', 200, 220);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A71', 'Áo lót', 'Quần áo', 'Gucci', 185, 205);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A73', 'Áo lót', 'Quần áo', 'Adidas', 170, 195);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A74', 'Áo lót', 'Quần áo', 'Nike', 190, 215);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A77', 'Áo lót', 'Quần áo', 'Uniqlo', 190, 205);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A83', 'Áo chống nắng', 'Quần áo', 'Adidas', 235, 250);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A84', 'Áo chống nắng', 'Quần áo', 'Nike', 190, 210);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A85', 'Áo chống nắng', 'Quần áo', 'AAA', 180, 205);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A87', 'Áo chống nắng', 'Quần áo', 'Uniqlo', 250, 265);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G13', 'Giày thể thao', 'Giày dép', 'Adidas', 970, 1010);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G14', 'Giày thể thao', 'Giày dép', 'Nike', 1055, 1100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G15', 'Giày thể thao', 'Giày dép', 'AAA', 890, 950);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G24', 'Giày lười', 'Giày dép', 'Nike', 515, 565);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G25', 'Giày lười', 'Giày dép', 'AAA', 450, 485);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G27', 'Giày lười', 'Giày dép', 'Uniqlo', 470, 500);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G33', 'Giày bata', 'Giày dép', 'Adidas', 45, 50);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G34', 'Giày bata', 'Giày dép', 'Nike', 35, 65);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G41', 'Giày cao gót', 'Giày dép', 'Gucci', 730, 765);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G42', 'Giày cao gót', 'Giày dép', 'Chanel', 675, 700);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G46', 'Giày cao gót', 'Giày dép', 'Calvin Klein', 750, 770);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G48', 'Giày cao gót', 'Giày dép', 'D&G', 765, 800);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D12', 'Dép tông', 'Giày dép', 'Chanel', 55, 70);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D18', 'Dép tông', 'Giày dép', 'D&G', 50, 55);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D21', 'Dép croc', 'Giày dép', 'Gucci', 85, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D22', 'Dép croc', 'Giày dép', 'Chanel', 90, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D25', 'Dép croc', 'Giày dép', 'AAA', 85, 105);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D28', 'Dép croc', 'Giày dép', 'D&G', 90, 115);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D31', 'Dép tổ ong', 'Giày dép', 'Gucci', 65, 70);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D32', 'Dép tổ ong', 'Giày dép', 'Chanel', 70, 80);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D44', 'Dép cao su', 'Giày dép', 'Nike', 95, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D46', 'Dép cao su', 'Giày dép', 'Calvin Klein', 105, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D45', 'Dép cao su', 'Giày dép', 'Nike', 100, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M13', 'Mũ lưỡi trai', 'Mũ nón', 'Adidas', 50, 55);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M14', 'Mũ lưỡi trai', 'Mũ nón', 'Nike', 45, 60);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M16', 'Mũ lưỡi trai', 'Mũ nón', 'Calvin Klein', 45, 50);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M21', 'Mũ rộng vành', 'Mũ nón', 'Gucci', 60, 70);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M22', 'Mũ rộng vành', 'Mũ nón', 'Chanel', 55, 75);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M28', 'Mũ rộng vành', 'Mũ nón', 'D&G', 60, 80);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M32', 'Mũ cao bồi', 'Mũ nón', 'Chanel', 105, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M35', 'Mũ cao bồi', 'Mũ nón', 'AAA', 110, 125);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M37', 'Mũ cao bồi', 'Mũ nón', 'Uniqlo', 95, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M45', 'Mũ bảo hiểm', 'Mũ nón', 'AAA', 115, 130);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M47', 'Mũ bảo hiểm', 'Mũ nón', 'Uniqlo', 120, 135);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M51', 'Mũ len', 'Mũ nón', 'Gucci', 70, 80);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M52', 'Mũ len', 'Mũ nón', 'Chanel', 75, 85);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M57', 'Mũ len', 'Mũ nón', 'Uniqlo', 80, 95);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M58', 'Mũ len', 'Mũ nón', 'D&G', 80, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M66', 'Mũ panama', 'Mũ nón', 'Calvin Klein', 185, 200);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M67', 'Mũ panama', 'Mũ nón', 'D&G', 190, 210);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M72', 'Mũ beret', 'Mũ nón', 'Chanel', 100, 115);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M75', 'Mũ beret', 'Mũ nón', 'AAA', 100, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M86', 'Mũ fedora', 'Mũ nón', 'Calvin Klein', 105, 130);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M87', 'Mũ fedora', 'Mũ nón', 'Uniqlo', 110, 135);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M88', 'Mũ fedora', 'Mũ nón', 'D&G', 90, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T11', 'Túi chữ nhật', 'Túi xách', 'Gucci', 1900, 1955);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T12', 'Túi chữ nhật', 'Túi xách', 'Chanel', 1985, 2000);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T18', 'Túi chữ nhật', 'Túi xách', 'D&G', 1995, 2005);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T23', 'Túi ba lô', 'Túi xách', 'Adidas', 1930, 1950);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T24', 'Túi ba lô', 'Túi xách', 'Nike', 1800, 1840);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T26', 'Túi ba lô', 'Túi xách', 'Calvin Klein', 1930, 1950);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T32', 'Túi tote', 'Túi xách', 'Chanel', 40, 50);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T37', 'Túi tote', 'Túi xách', 'Uniqlo', 45, 60);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T41', 'Túi pucket', 'Túi xách', 'Gucci', 85, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T46', 'Túi pucket', 'Túi xách', 'Calvin Klein', 120, 130);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T48', 'Túi pucket', 'Túi xách', 'D&G', 115, 145);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T55', 'Túi clutch', 'Túi xách', 'AAA', 120, 155);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T58', 'Túi clutch', 'Túi xách', 'D&G', 120, 140);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T62', 'Túi crossbody', 'Túi xách', 'Chanel', 235, 250);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T65', 'Túi crossbody', 'Túi xách', 'AAA', 215, 255);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P11', 'Hoa tai hình hoa', 'Phụ kiện', 'Gucci', 25, 30);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P12', 'Hoa tai hình hoa', 'Phụ kiện', 'Chanel', 40, 45);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P23', 'Hoa tai hình nước', 'Phụ kiện', 'Adidas', 30, 35);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P25', 'Hoa tai hình nước', 'Phụ kiện', 'AAA', 20, 30);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P31', 'Hoa tai quả táo', 'Phụ kiện', 'Gucci', 25, 30);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P37', 'Hoa tai quả táo', 'Phụ kiện', 'Uniqlo', 20, 45);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P41', 'Kính râm', 'Phụ kiện', 'Gucci', 15, 35);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P42', 'Kính râm', 'Phụ kiện', 'Chanel', 35, 40);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P47', 'Kính râm', 'Phụ kiện', 'Uniqlo', 45, 50);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P48', 'Kính râm', 'Phụ kiện', 'D&G', 50, 55);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P57', 'Gọng kính', 'Phụ kiện', 'Uniqlo', 30, 35);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P58', 'Gọng kính', 'Phụ kiện', 'D&G', 50, 60);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P61', 'Đồng hồ nam', 'Phụ kiện', 'Gucci', 850, 875);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P67', 'Đồng hồ nam', 'Phụ kiện', 'Uniqlo', 880, 900);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P68', 'Đồng hồ nam', 'Phụ kiện', 'D&G', 900, 925);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P71', 'Đồng hồ nữ', 'Phụ kiện', 'Gucci', 850, 875);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P72', 'Đồng hồ nữ', 'Phụ kiện', 'Chanel', 970, 990);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P82', 'Cà vạt', 'Phụ kiện', 'Chanel', 300, 345);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P85', 'Cà vạt', 'Phụ kiện', 'AAA', 320, 350);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P87', 'Cà vạt', 'Phụ kiện', 'Uniqlo', 345, 360);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P92', 'Nước hoa', 'Phụ kiện', 'Chanel', 1150, 1200);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P94', 'Nước hoa', 'Phụ kiện', 'Nike', 1105, 1150);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P96', 'Cà vạt', 'Phụ kiện', 'Calvin Klein', 1285, 1300);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P101', 'Gang tay', 'Phụ kiện', 'Gucci', 90, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P102', 'Gang tay', 'Phụ kiện', 'Chanel', 100, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P113', 'Tất cổ dài', 'Phụ kiện', 'Adidas', 15, 20);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P114', 'Tất cổ dài', 'Phụ kiện', 'Nike', 20, 25);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P118', 'Tất cổ dài', 'Phụ kiện', 'D&G', 25, 30);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P123', 'Tất cổ ngắn', 'Phụ kiện', 'Adidas', 10, 15);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P124', 'Tất cổ ngắn', 'Phụ kiện', 'Nike', 15, 20);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P125', 'Tất cổ ngắn', 'Phụ kiện', 'AAA', 10, 15);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P133', 'Ô', 'Phụ kiện', 'Adidas', 55, 60);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P134', 'Ô', 'Phụ kiện', 'Nike', 60, 70);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P135', 'Ô', 'Phụ kiện', 'AAA', 75, 80);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P141', 'Ghim cài áo', 'Phụ kiện', 'Gucci', 90, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P142', 'Ghim cài áo', 'Phụ kiện', 'Chanel', 100, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P146', 'Ghim cài áo', 'Phụ kiện', 'Calvin Klein', 110, 115);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P147', 'Ghim cài áo', 'Phụ kiện', 'Uniqlo', 100, 125);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P148', 'Ghim cài áo', 'Phụ kiện', 'D&G', 150, 165);

-- Kho
INSERT INTO Kho(Ma_kho, So_luong_toi_da, So_luong_thuc_te,So_luong_con_trong) VALUES ('1', 2000, 1256, null);
INSERT INTO Kho(Ma_kho, So_luong_toi_da, So_luong_thuc_te,So_luong_con_trong) VALUES ('2', 3000, 1110, null);
INSERT INTO Kho(Ma_kho, So_luong_toi_da, So_luong_thuc_te,So_luong_con_trong) VALUES ('3', 2500, 1310, null);
INSERT INTO Kho(Ma_kho, So_luong_toi_da, So_luong_thuc_te,So_luong_con_trong) VALUES ('4', 2000, 1516, null);
INSERT INTO Kho(Ma_kho, So_luong_toi_da, So_luong_thuc_te,So_luong_con_trong) VALUES ('5', 4000, 2528, null);

-- Kho chua
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q11', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q16', 10, '2021-06-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q17', 50, '2021-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q18', 50, '2021-08-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q22', 50, '2021-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q23', 50, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q24', 50, '2021-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q26', 50, '2021-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q27', 50, '2021-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q28', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q31', 10, '2021-06-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q37', 10, '2021-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q38', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q42', 10, '2021-08-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q43', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q44', 10, '2021-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q46', 10, '2021-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q48', 10, '2021-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q51', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q55', 10, '2021-06-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'Q57', 10, '2021-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'V11', 10, '2021-08-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'V12', 10, '2021-09-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'V18', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'V21', 10, '2021-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'V25', 10, '2021-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'V26', 10, '2021-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'V34', 10, '2021-06-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'V37', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A12', 10, '2021-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A17', 10, '2021-08-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A18', 10, '2021-08-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A21', 10, '2021-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A22', 10, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A23', 10, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A24', 10, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A25', 10, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A27', 10, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A28', 10, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A31', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A32', 10, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A33', 10, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A34', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A36', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A37', 10, '2021-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A38', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A41', 10, '2021-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A43', 10, '2021-08-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A44', 10, '2021-12-16' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A45', 10, '2021-05-14' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A48', 10, '2021-04-13' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A54', 10, '2021-03-11' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A57', 10, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A58', 10, '2021-04-12' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A62', 10, '2021-06-18' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A63', 10, '2021-08-10' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'A66', 10, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'A71', 20, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'A73', 20, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'A74', 20, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'A77', 20, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'A83', 20, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'A84', 20, '2022-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'A85', 20, '2022-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'A87', 20, '2022-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G13', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G14', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G15', 20, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G24', 20, '2022-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G25', 20, '2022-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G27', 20, '2022-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G33', 20, '2022-06-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G34', 20, '2022-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G41', 20, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G42', 20, '2022-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G46', 20, '2022-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'G48', 20, '2022-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'D12', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'D18', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'D21', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'D22', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'D25', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'D18', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'D18', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'D28', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'D28', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'D28', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D28', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D28', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D28', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D28', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D28', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D18', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D12', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D12', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D21', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D46', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D44', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D31', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'D32', 20, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M13', 15, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M14', 15, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M16', 15, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M21', 15, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M22', 15, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M28', 15, '2022-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M32', 15, '2022-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M35', 15, '2022-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M37', 15, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M45', 15, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M47', 15, '2022-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M51', 15, '2022-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M52', 15, '2022-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M57', 15, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M58', 15, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M66', 15, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M67', 15, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M66', 15, '2022-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M72', 15, '2022-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M75', 15, '2022-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M86', 15, '2022-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M87', 15, '2022-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M88', 15, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M32', 15, '2022-06-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M13', 15, '2022-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M14', 15, '2022-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M13', 15, '2022-02-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M13', 15, '2022-01-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M14', 15, '2022-03-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M22', 15, '2022-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M28', 15, '2022-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'M51', 15, '2022-06-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T11', 17, '2021-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T12', 17, '2021-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T18', 17, '2021-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T23', 17, '2021-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T24', 17, '2021-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T26', 17, '2021-07-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T32', 17, '2021-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T11', 17, '2021-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T37', 17, '2021-04-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T11', 17, '2021-05-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'A41', 17, '2021-06-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T11', 17, '2021-06-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T46', 17, '2021-08-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T48', 17, '2021-08-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'A33', 17, '2021-08-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T58', 17, '2021-08-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T62', 17, '2021-09-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T11', 17, '2021-09-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T65', 17, '2021-09-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T18', 17, '2021-09-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T23', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T23', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T11', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T41', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T46', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T11', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T62', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T65', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('5', 'T65', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'P11', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'P12', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'P23', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'P23', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'P25', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'P31', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'P37', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'P41', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('1', 'P42', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P47', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P48', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P57', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P58', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P57', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P58', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P57', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'A33', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P61', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P67', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P68', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P68', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P61', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P67', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P68', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P71', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P72', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P72', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P82', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P85', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P87', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P87', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P85', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P82', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P85', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P82', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P87', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P92', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P94', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P96', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('2', 'P101', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P102', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P102', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P102', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P113', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P114', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P118', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P123', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P124', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P125', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P133', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P134', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P135', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P141', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P142', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P146', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('3', 'P147', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P148', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P123', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P124', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P125', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P123', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P124', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P125', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P141', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P142', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P146', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P102', 17, '2021-12-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P125', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P124', 17, '2021-11-15' );
INSERT INTO Kho_chua(Ma_kho, Ma_hang, So_luong_nhap, Ngay_nhap_hang) VALUES ('4', 'P123', 17, '2021-11-15' );


-- Don hang
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID) VALUES ('MD1', 'Giao hàng thành công','Online', '2022-05-23', '6' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD2', 'Giao hàng thành công','Online', '2022-06-23', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD3', 'Giao hàng thành công','Online', '2022-07-23', '8' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD4', 'Giao hàng thành công','Online', '2022-08-21', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD5', 'Giao hàng thành công','Online', '2022-09-21', '10' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD6', 'Giao hàng thành công','Online', '2022-12-26', '4' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD7', 'Giao hàng thành công','Online', '2022-11-27', '5' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD8', 'Giao hàng thành công','Online', '2022-11-28', '1' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD9', 'Giao hàng thành công','Online', '2022-11-29', '3' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD10', 'Giao hàng thành công','Online', '2022-11-24', '4' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD11', 'Giao hàng thành công','Online', '2022-12-25', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD12', 'Giao hàng thành công','Online', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD13', 'Giao hàng thành công','Tiền mặt', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD14', 'Giao hàng thành công','Tiền mặt', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD15', 'Giao hàng thành công','Tiền mặt', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD16', 'Giao hàng thành công','Tiền mặt', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD17', 'Giao hàng thành công','Tiền mặt', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD18', 'Giao hàng thành công','Tiền mặt', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD19', 'Giao hàng thành công','Tiền mặt', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD20', 'Giao hàng thành công','Tiền mặt', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD21', 'Đang giao hàng','Tiền mặt', '2022-02-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD22', 'Đang giao hàng','Tiền mặt', '2022-07-06', '10' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD23', 'Đang giao hàng','Tiền mặt', '2022-08-07', '11' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD24', 'Đang giao hàng','Tiền mặt', '2022-09-08', '13' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD25', 'Đang giao hàng','Tiền mặt', '2022-01-08', '14' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD26', 'Đang giao hàng','Tiền mặt', '2022-02-02', '16' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD27', 'Đang giao hàng','Tiền mặt', '2022-03-15', '16' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD28', 'Đang giao hàng','Tiền mặt', '2022-04-15', '54' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD29', 'Đang giao hàng','Tiền mặt', '2022-02-15', '23' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD30', 'Bị hủy','Tiền mặt', '2022-02-14', '23' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD31', 'Bị hủy','Tiền mặt', '2022-01-15', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD32', 'Bị hủy','Tiền mặt', '2022-03-16', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD33', 'Bị hủy','Tiền mặt', '2022-04-17', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD34', 'Bị hủy','Tiền mặt', '2022-05-18', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD35', 'Bị hủy','Tiền mặt', '2022-06-19', '23' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD36', 'Bị hủy','Tiền mặt', '2022-02-10', '46' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD37', 'Bị hủy','Tiền mặt', '2022-08-12', '78' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD38', 'Bị hủy','Tiền mặt', '2022-09-12', '86' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD39', 'Bị hủy','Tiền mặt', '2022-10-16', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD40', 'Đã phê duyệt','Online', '2022-11-16', '44' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD41', 'Đã phê duyệt','Online', '2022-12-12', '23' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD42', 'Đã phê duyệt','Online', '2022-01-13', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD43', 'Đã phê duyệt','Online', '2022-11-14', '76' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD44', 'Đã phê duyệt','Online', '2022-11-15', '75' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD45', 'Đã phê duyệt','Online', '2022-10-16', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD46', 'Đã phê duyệt','Online', '2022-12-17', '65' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD47', 'Đã phê duyệt','Online', '2022-10-18', '21' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD48', 'Đã phê duyệt','Online', '2022-12-16', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD49', 'Đã phê duyệt','Online', '2022-10-16', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD50', 'Giao hàng không thành công','Online', '2022-12-21', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD51', 'Giao hàng không thành công','Online', '2022-11-22', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD52', 'Giao hàng không thành công','Online', '2022-10-23', '26' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD53', 'Giao hàng không thành công','Online', '2022-10-26', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD54', 'Giao hàng không thành công','Online', '2022-11-24', '46' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD55', 'Giao hàng không thành công','Online', '2022-10-25', '53' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD56', 'Giao hàng không thành công','Online', '2022-12-26', '63' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD57', 'Giao hàng không thành công','Online', '2022-11-17', '53' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD58', 'Giao hàng không thành công','Online', '2022-11-27', '53' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD59', 'Giao hàng không thành công','Online', '2022-11-16', '57' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD60', 'Giao hàng không thành công','Tiền mặt', '2021-01-02', '54' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD61', 'Giao hàng không thành công','Tiền mặt', '2021-02-03', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD62', 'Giao hàng không thành công','Tiền mặt', '2021-03-04', '54' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD63', 'Giao hàng không thành công','Tiền mặt', '2021-04-05', '65' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD64', 'Giao hàng không thành công','Tiền mặt', '2021-05-06', '74' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD65', 'Giao hàng không thành công','Tiền mặt', '2021-06-07', '86' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD66', 'Giao hàng không thành công','Tiền mặt', '2021-07-08', '91' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD67', 'Giao hàng không thành công','Tiền mặt', '2021-08-09', '32' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD68', 'Giao hàng không thành công','Tiền mặt', '2021-09-01', '78' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD69', 'Giao hàng không thành công','Tiền mặt', '2021-03-03', '84' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD70', 'Đang giao hàng','Online', '2021-03-03', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD71', 'Đang giao hàng','Online', '2021-04-03', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD72', 'Đang giao hàng','Online', '2021-05-03', '32' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD73', 'Đang giao hàng','Online', '2021-06-03', '43' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD74', 'Đang giao hàng','Online', '2021-06-03', '65' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD75', 'Đang giao hàng','Online', '2021-07-03', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD76', 'Đang giao hàng','Online', '2021-08-03', '64' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD77', 'Đang giao hàng','Online', '2021-09-03', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD78', 'Đang giao hàng','Online', '2021-01-03', '67' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD79', 'Đang giao hàng','Online', '2021-04-03', '87' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD80', 'Chờ phê duyệt','Online', '2021-04-01', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD81', 'Chờ phê duyệt','Online', '2021-01-02', '23' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD82', 'Chờ phê duyệt','Online', '2021-02-03', '4' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD83', 'Chờ phê duyệt','Online', '2021-04-04', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD84', 'Chờ phê duyệt','Online', '2021-05-05', '47' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD85', 'Chờ phê duyệt','Online', '2021-06-06', '57' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD86', 'Chờ phê duyệt','Online', '2021-07-07', '67' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD87', 'Chờ phê duyệt','Online', '2021-08-08', '27' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD88', 'Chờ phê duyệt','Online', '2021-09-03', '57' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD89', 'Chờ phê duyệt','Online', '2021-07-04', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD90', 'Chờ phê duyệt','Tiền mặt', '2021-03-03', '1' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD91', 'Chờ phê duyệt','Tiền mặt', '2021-05-04', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD92', 'Chờ phê duyệt','Tiền mặt', '2021-04-05', '47' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD93', 'Chờ phê duyệt','Tiền mặt', '2021-06-06', '57' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD94', 'Chờ phê duyệt','Tiền mặt', '2021-07-07', '67' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD95', 'Chờ phê duyệt','Tiền mặt', '2021-09-08', '37' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD96', 'Chờ phê duyệt','Tiền mặt', '2021-07-09', '37' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD97', 'Chờ phê duyệt','Tiền mặt', '2021-01-05', '87' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD98', 'Chờ phê duyệt','Tiền mặt', '2021-04-03', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD99', 'Chờ phê duyệt','Tiền mặt', '2021-07-01', '97' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD100', 'Đã phê duyệt','Online', '2021-01-11', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD101', 'Đã phê duyệt','Online', '2021-01-10', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD102', 'Bị hủy','Online', '2020-01-14', '4' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD103', 'Bị hủy','Online', '2020-04-14', '3' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD104', 'Bị hủy','Online', '2020-05-14', '4' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD105', 'Bị hủy','Online', '2020-06-13', '5' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD106', 'Bị hủy','Online', '2020-07-15', '6' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD107', 'Bị hủy','Online', '2020-08-16', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD108', 'Bị hủy','Online', '2020-03-17', '8' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD109', 'Bị hủy','Online', '2020-04-18', '8' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD110', 'Bị hủy','Online', '2020-05-19', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD111', 'Bị hủy','Tiền mặt', '2020-05-14', '90' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD112', 'Bị hủy','Tiền mặt', '2020-05-12', '91' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD113', 'Bị hủy','Tiền mặt', '2020-05-14', '94' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD114', 'Bị hủy','Tiền mặt', '2020-05-15', '5' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD115', 'Bị hủy','Tiền mặt', '2020-05-13', '54' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD116', 'Bị hủy','Tiền mặt', '2020-05-16', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD117', 'Bị hủy','Tiền mặt', '2020-05-15', '57' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD118', 'Bị hủy','Tiền mặt', '2020-05-18', '76' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD119', 'Bị hủy','Tiền mặt', '2020-05-19', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD120', 'Đang giao hàng','Tiền mặt', '2020-09-14', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD121', 'Đang giao hàng','Tiền mặt', '2020-08-13', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD122', 'Đang giao hàng','Tiền mặt', '2020-07-12', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD123', 'Đang giao hàng','Tiền mặt', '2020-06-13', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD124', 'Đang giao hàng','Tiền mặt', '2020-06-12', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD125', 'Đang giao hàng','Tiền mặt', '2020-03-09', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD126', 'Đang giao hàng','Tiền mặt', '2020-03-09', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD127', 'Đang giao hàng','Tiền mặt', '2020-02-09', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD128', 'Đang giao hàng','Tiền mặt', '2020-07-09', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD129', 'Đang giao hàng','Tiền mặt', '2020-06-13', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD130', 'Đang giao hàng','Tiền mặt', '2020-06-14', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD131', 'Đang giao hàng','Tiền mặt', '2020-05-12', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD132', 'Đang giao hàng','Tiền mặt', '2020-04-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD133', 'Đang giao hàng','Tiền mặt', '2020-02-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD134', 'Đang giao hàng','Tiền mặt', '2020-01-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD135', 'Đang giao hàng','Tiền mặt', '2020-09-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD136', 'Đang giao hàng','Tiền mặt', '2020-08-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD137', 'Đang giao hàng','Tiền mặt', '2020-07-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD138', 'Đang giao hàng','Tiền mặt', '2020-06-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD139', 'Đang giao hàng','Tiền mặt', '2020-05-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD140', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD141', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '14' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD142', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD143', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD144', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '55' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD145', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '5' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD146', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD147', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '75' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD148', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '75' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD149', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '85' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD150', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '95' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD151', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD152', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '25' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD153', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '35' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD154', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD155', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '55' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD156', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '16' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD157', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '16' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD158', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '16' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD159', 'Giao hàng không thành công','Tiền mặt', '2020-04-12', '1' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD160', 'Giao hàng không thành công','Online', '2022-05-14', '1' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD161', 'Giao hàng không thành công','Online', '2022-05-14', '61' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD162', 'Giao hàng không thành công','Online', '2022-05-14', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD163', 'Giao hàng không thành công','Online', '2022-05-14', '62' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD164', 'Giao hàng không thành công','Online', '2022-05-14', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD165', 'Giao hàng không thành công','Online', '2022-05-14', '61' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD166', 'Giao hàng không thành công','Online', '2022-05-14', '51' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD167', 'Giao hàng không thành công','Online', '2022-05-14', '71' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD168', 'Giao hàng không thành công','Online', '2022-05-14', '81' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD169', 'Giao hàng không thành công','Online', '2022-05-14', '91' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD170', 'Đang giao hàng','Online', '2022-05-16', '13' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD171', 'Đang giao hàng','Online', '2022-05-17', '14' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD172', 'Đang giao hàng','Online', '2022-05-18', '31' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD173', 'Đang giao hàng','Online', '2022-05-19', '1' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD174', 'Đang giao hàng','Online', '2022-05-21', '41' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD175', 'Đang giao hàng','Online', '2022-05-23', '41' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD176', 'Đang giao hàng','Online', '2022-05-11', '11' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD177', 'Đang giao hàng','Online', '2022-05-12', '61' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD178', 'Đang giao hàng','Online', '2022-05-23', '71' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD179', 'Đang giao hàng','Online', '2022-05-05', '81' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD180', 'Đang giao hàng','Online', '2022-05-09', '91' );

-- Hoa don




-- Thong tin don hang
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD1','Q11', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD2','Q16', 6, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD3','Q17', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD4','Q18', 2, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD5','Q11', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD6','Q11', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD7','Q11', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD8','Q11', 6, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD9','Q11', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD10','Q11', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD11','Q11', 9, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD12','Q11', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD13','Q22', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD14','Q22', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD15','Q22', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD16','Q22', 6, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD17','Q22', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD18','Q22', 17, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD19','Q22', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD20','Q43', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD21','Q43', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD22','Q43', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD23','Q43', 6, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD24','Q43', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD25','Q43', 8, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD26','Q43', 9, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD27','Q43', 9, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD28','Q43', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD29','A12', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD30','A12', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD31','G24', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD32','G24', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD33','G24', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD34','G24', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD35','G24', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD36','G24', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD37','G24', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD38','G24', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD39','G24', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD40','A41', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD41','A41', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD42','A41', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD43','A48', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD44','A41', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD45','A45', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD46','A41', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD47','A43', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD48','A41', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD49','A41', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD50','A44', 10, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD51','A44', 10, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD52','A44', 10, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD53','A43', 10, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD54','A45', 10, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD55','A48', 10, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD56','A44', 10, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD57','A43', 10, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD58','A44', 10, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD59','A44', 10, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD60','A71', 2, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD61','A73', 2, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD62','A73', 2, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD63','A74', 2, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD64','A73', 2, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD65','A77', 2, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD66','A71', 2, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD67','A74', 2, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD68','A73', 2, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD69','A73', 2, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD70','Q31', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD71','Q37', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD72','Q38', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD73','Q38', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD74','Q38', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD75','Q37', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD76','Q38', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD77','Q37', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD78','Q31', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD79','Q31', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD80','V11', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD81','V12', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD82','V18', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD83','V21', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD84','V25', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD85','V26', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD86','V34', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD87','V37', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD88','V37', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD89','V37', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD90','A21', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD91','A22', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD92','A23', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD93','A24', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD94','A25', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD95','A27', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD96','A27', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD97','A28', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD98','A54', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD99','A57', 5, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD100','A58', 6, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD101','A31', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD102','A32', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD103','A33', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD104','A34', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD105','A36', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD106','A36', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD107','A37', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD108','A38', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD109','A32', 3, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD110','G13', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD111','G14', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD112','G15', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD113','G24', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD114','G25', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD115','G27', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD116','G33', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD117','G34', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD118','G41', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD119','G42', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD120','G46', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD121','G48', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD122','D12', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD123','D18', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD124','D21', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD125','D22', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD126','D25', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD127','D28', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD128','D44', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD129','D46', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD130','D46', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD131','M13', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD132','M14', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD133','M16', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD134','M21', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD135','M22', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD136','M28', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD137','M32', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD138','M35', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD139','M37', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD140','M45', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD141','M47', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD142','M51', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD143','M52', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD144','M57', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD145','M58', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD146','M66', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD147','M67', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD148','M72', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD149','M75', 7, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD150','M86', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD151','M87', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD152','M88', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD153','T11', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD154','T12', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD155','T18', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD156','T23', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD157','T24', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD158','T26', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD159','T32', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD160','T37', 1, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD161','P11', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD162','P12', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD163','P23', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD164','P25', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD165','P31', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD166','P37', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD167','P41', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD168','P42', 4, null  ); 
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD169','P47', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD170','P48', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD171','P57', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD172','P58', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD173','P61', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD174','P67', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD175','P68', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD176','P71', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD177','P72', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD178','P82', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD179','P85', 4, null  );
INSERT INTO Thong_tin_don_hang(Ma_don, Ma_hang, So_luong, Thanh_tien) VALUES ('MD180','P87', 4, null  );


CREATE OR REPLACE FUNCTION af_Nhap_hang() RETURNS TRIGGER
AS
$$
BEGIN
	update Kho set So_luong_thuc_te = So_luong_thuc_te + NEW.So_luong_nhap
    where NEW.Ma_kho = Kho.Ma_kho;
    update Kho set So_luong_con_trong = So_luong_toi_da - So_luong_thuc_te
    where NEW.Ma_kho = Kho.Ma_kho;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER af_Nhap_hang
AFTER INSERT ON Kho_chua
FOR EACH ROW
WHEN (NEW.Ma_kho is not NULL)
EXECUTE PROCEDURE af_Nhap_hang();


CREATE OR REPLACE FUNCTION thanh_tien(IN mahang char(10),IN so_luong integer, OUT tien integer)
AS
$$
DECLARE x integer :=0;
BEGIN
    select into x m.gia_ban
    from mathang m
    where mahang = m.ma_hang;
    tien = so_luong * x;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_thanh_tien() RETURNS integer
AS
$$
DECLARE mahang char(10);
BEGIN
    FOR mahang IN (select ma_hang from thong_tin_don_hang) LOOP
        UPDATE thong_tin_don_hang set thanh_tien = thanh_tien(mahang,so_luong)
        where ma_hang = mahang;
    END LOOP;
    RETURN 1;
END;
$$
LANGUAGE plpgsql;
select update_thanh_tien();


CREATE OR REPLACE FUNCTION afup_Don_hang() RETURNS TRIGGER
AS
$$
DECLARE x record;
BEGIN
    select into x * from Thong_tin_don_hang where Ma_don = NEW.Ma_don;
	if (lower(NEW.Tinh_trang_don) = 'đã phê duyệt') then
        update Kho set So_luong_thuc_te = So_luong_thuc_te - x.So_luong where ma_kho ='1' ;
    end if;
    if (lower(NEW.Tinh_trang_don) = 'bị hủy') then
        update Kho set So_luong_thuc_te = So_luong_thuc_te + x.So_luong where ma_kho ='2' ;
    end if;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER afup_Don_hang
AFTER UPDATE ON Don_hang
FOR EACH ROW
WHEN (lower(NEW.Tinh_trang_don) = 'đã phê duyệt' OR lower(NEW.Tinh_trang_don) = 'bị hủy')
EXECUTE PROCEDURE afup_Don_hang();