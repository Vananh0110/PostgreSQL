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
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('1', 'Ph???m V??n Anh', '097834567', '2002-10-01','Ph?? Ch??u, ????ng H??ng, Th??i B??nh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('2', 'Ho??ng Th??? Anh', '097833421', '2002-10-04','Ph?? Ch??u, ????ng H??ng, B???c Giang', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('3', 'Nguy???n ?????c Anh', '0978239833', '2002-09-01','H??a L???c, ????ng H??ng, Th??i B??nh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('4', 'Nguy???n V??n Anh', '0978349846', '2000-10-01','Ph?? Ch??u, ????ng H??ng, Ha Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('5', 'Ph???m V??n ??nh', '097823219', '2001-04-01','Ph?? Ch??u, Duy Ti??n, L??o Cai', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('6', 'Ph???m V??n An', '097346787', '2003-09-02','Ph?? Ch??u, Thanh Li??m, Nam ?????nh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('7', 'Ph???m Thi??n An', '097238965', '2001-04-28','Li??m Tuy???n, ????ng H??ng, B???c Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('8', 'Ph???m Xu??n Duy', '097234565', '2001-05-23','Li??m Tuy???n, ????ng H??ng, H???i D????ng', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('9', 'Ph???m Thu???n', '095432965', '2000-07-18','L???c Ng???n, Hi???p H??a, H?? T??y', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('10', 'Nguy???n ?????c Ho??ng', '097234532', '2001-04-28','Thanh Li??m, Duy Ti??n, B???c Ninh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('11', 'Ph???m H???u Th??i', '097345125', '2000-03-08','Li??m Ch??nh, ????ng Mai, Ninh B??nh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('12', 'Ph???m Tu???n Nam', '097232156', '2001-04-21','Li??m Thu???n, Kim B???ng, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('13', 'Ng?? Ki???n Huy', '092134532', '1999-05-01','Li??m Tuy???n, ????ng H??ng, h?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('14', 'Ph???m Thi??n Tu???n', '097234215', '2001-10-31','B???c Tuy???n, ????ng B???c, B???c Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('15', 'Nguy???n Thi??n An', '097232365', '2001-01-24','Li??m H????ng, H??a H??ng, Ninh Thu???n', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('16', 'Ph???m Thi??n Ph??c', '0972123165', '2000-04-28','Thanh H????ng, ????ng H??ng, Thanh H??a', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('17', 'Ph???m Nh???t V?????ng', '097123165', '2001-08-08','Li??m Tuy???n, Ph??? L??, h?? Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('18', 'Ph???m Ti???n L???c', '097123265', '2004-04-28','Li??m C???n, ????ng Ch??c, L??o Cai', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('19', 'Ph???m Xu??n An', '0973412235', '2001-06-25','L???c Ng???n, Hi???p H??a, B???c Giang', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('20', 'Ng?? B???o Ch??u', '097221345', '1993-03-28','Li??m T??c, ????ng H??ng, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('21', 'Nguy???n Duy Tu???n', '0972311223', '2000-04-12','Li??m Thanh, ????ng Nam, B???c Ninh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('22', 'Nguy???n Duy Phong', '0972341223', '2001-03-12','Li??m T??c, ????ng H??ng, B???c Ninh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('23', 'Nguy???n Duy Nam', '0972342323', '2001-05-04','Li??m Tranh, ????ng B???c, B???c Giang', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('24', 'Nguy???n Duy Ho??ng', '0972321223', '2001-05-04','Li??m Tanh, ????ng Mai, B???c C???nh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('25', 'Nguy???n Duy Kh??nh', '097257223', '2001-06-30','Li??m Tanh, ????ng T??y, B???c Giang', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('26', 'Nguy???n Duy Long', '09724554223', '2001-03-04','Li??m Tanh, ????ng H???i, B???c Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('27', 'Nguy???n Duy Anh', '0973425773', '2001-02-09','Li??m Tanh, ????ng H???c, B???c Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('28', 'Nguy???n Duy B???c', '0972345464', '2001-02-03','Li??m Tanh, Nam H??ng, B???c Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('29', 'Nguy???n Duy ????ng', '09723454634', '2001-02-04','Li??m Tanh, ????ng H??ng, B???c Ninh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('30', 'Nguy???n Duy T??y', '097235678', '2001-02-11','Li??m Tanh, T??y H??ng, B???c Ninh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('31', 'Nguy???n Duy H??', '0972435634', '2001-02-12','Li??m Tanh, Mai H??ng, B???c Ninh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('32', 'L?? Th??? H??', '097232442321', '1998-02-12','Thanh Li??m, Thanh H????ng, H?? Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('33', 'L?? Th??? Ho??ng', '0972323141', '1998-04-12','Thanh Li??m, Thanh Mai, H?? Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('34', 'L?? Th??? Nam', '097234425', '1998-05-12','Thanh Li??m, Thanh H????ng, H?? Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('35', 'L?? Th??? H??', '0972327781', '1998-06-12','Thanh Li??m, Thanh H????ng, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('36', 'L?? Th??? H??', '0972325651', '1998-07-12','Thanh H???i, Thanh H????ng, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('37', 'L?? Th??? H??', '0972367881', '1998-08-12','Thanh Loan, Thanh Giang, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('38', 'L?? Th??? H??', '0972356858', '1998-09-12','Thanh Ngh???, Thanh Tuy???t, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('39', 'L?? Th??? H??', '0972365788', '1998-10-10','Thanh Ch??c, Thanh X??, H?? Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('40', 'L?? Th??? H??', '0972324241', '1998-11-12','Thanh Kh??, Thanh H????ng, H?? Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('41', '?????ng Th??? Nhung', '0972324345', '1985-11-01','L???c C???n, ?????ng T??m, H??? Ch?? Minh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('42', '?????ng Th??? Thuy???t', '0972323577', '1985-01-01','L???c C???n, ?????ng Nam, H??? Ho??n Ki???m', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('43', '?????ng Th??? Mai', '0972345678', '1985-12-01','L???c C???n, ?????ng B???c, H??? Ba V??', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('44', '?????ng Th??? Nhun', '0972321345', '1985-04-01','L???c C???n, ?????ng T??y, H??? M???t C???t', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('45', '?????ng Th??? Nh??', '0456784345', '1985-04-01','L???c C???n, ?????ng D???ng, H??? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('46', '?????ng Th??? Mai', '0967544345', '1985-11-01','L???c C???n, ?????ng N??t H??? B???c Minh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('47', '?????ng Th??? Tuy???t', '0345674345', '1985-12-01','L???c C???n, ?????ng C??, H??? Anh Minh', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('48', '?????ng Th??? B??ch', '0976544345', '1985-04-01','L???c C???n, ?????ng ????, H??? S??n Minh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('49', '?????ng Th??? Ng???c', '0912344345', '1985-04-01','L???c C???n, ?????ng T??m, H??? C???u Minh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('50', '?????ng Th??? Kim', '0956784345', '1985-05-01','L???c C???n, ?????ng Mai, H??? T??m Minh', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('51', 'Ho??ng H???ng Nhung', '095324245', '1982-01-01','Ph?? L??, H?? Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('52', 'Ho??ng H???ng Mai', '095334245', '1982-02-02','Ph?? L??, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('53', 'Ho??ng H???ng ????ng', '095677545', '1982-03-01','Ph?? L??, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('54', 'Ho??ng H???ng Cung', '097556545', '1982-04-04','Ph?? L??, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('55', 'Ho??ng H???ng Hoa', '097564545', '1982-05-05','Ph?? L??, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('56', 'Ho??ng H???ng Tuy???t', '098755645', '1982-05-06','Ph?? L??, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('57', 'Ho??ng H???ng Mai', '093435645', '1982-06-08','Ph?? L??, H?? Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('58', 'Ho??ng H???ng B??ch', '093356645', '1982-07-06','Ph?? L??, H?? Nam', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('59', 'Ho??ng H???ng Oanh', '095456445', '1982-08-09','Ph?? L??, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('60', 'Ng?? Ki???n Giang', '095434225', '1992-08-09','121 L?? Thanh Ngh???, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('61', 'Ng?? Ki???n Giang', '095232125', '1992-04-04','123 L?? Thanh Ngh???, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('62', 'Ng?? Ki???n Giang', '095453325', '1992-03-05','124 L?? Thanh Ngh???, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('63', 'Ng?? Ki???n Giang', '095445325', '1992-05-06','125 L?? Thanh Ngh???, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('64', 'Ng?? Ki???n Giang', '095342425', '1992-06-09','155 L?? Thanh Ngh???, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('65', 'Ng?? Ki???n Giang', '095454335', '1992-07-03','161 L?? Thanh Ngh???, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('66', 'Ng?? Ki???n Giang', '095423125', '1992-02-03','171 L?? Thanh Ngh???, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('67', 'Ng?? Ki???n Giang', '095342325', '1992-01-09','181 L?? Thanh Ngh???, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('68', 'Ng?? Ki???n Giang', '095452425', '1992-03-08','121 L?? Thanh Ngh???, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('69', 'Ng?? Ki???n Giang', '095412325', '1992-04-02','131 L?? Thanh Ngh???, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('70', 'Nguy???n V??n Nam', '095234325', '1982-01-12','113 B???ch Mai, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('71', 'Nguy???n V??n B???c', '095231325', '1982-03-14','112 B???ch Mai, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('72', 'Nguy???n V??n ????ng', '023144325', '1982-03-15','113 B???ch Mai, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('73', 'Nguy???n V??n T??y', '092314325', '1982-04-16','115 B???ch Mai, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('74', 'Nguy???n V??n Kinh', '056445325', '1982-05-18','115 B???ch Mai, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('75', 'Nguy???n V??n B???o ', '096466325', '1982-06-18','116 B???ch Mai, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('76', 'Nguy???n V??n ????ng', '095234343', '1982-07-12','117 B???ch Mai, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('77', 'Nguy???n V??n C???u', '095235332', '1982-08-13','151 B???ch Mai, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('78', 'Nguy???n V??n Mai', '095242675', '1982-09-12','141 B???ch Mai, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('79', 'Nguy???n V??n V??', '095236443', '1982-03-14','131 B???ch Mai, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('80', 'Tr???n Th??nh', '0954334225', '1985-01-25','161 Tr???n ?????i Ngh??a, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('81', 'Tr???n Th??nh', '0952324225', '1985-02-21','31 Tr???n ?????i Ngh??a, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('82', 'Tr???n Th??nh', '0932244225', '1985-03-22','11 Tr???n ?????i Ngh??a, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('83', 'Tr???n Th??nh', '0954644225', '1985-04-23','16 Tr???n ?????i Ngh??a, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('84', 'Tr???n Th??nh', '0955434225', '1985-05-24','165 Tr???n ?????i Ngh??a, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('85', 'Tr???n Th??nh', '0923224225', '1985-06-26','178 Tr???n ?????i Ngh??a, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('86', 'Tr???n Th??nh', '0954434225', '1985-01-27','187 Tr???n ?????i Ngh??a, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('87', 'Tr???n Th??nh', '0954334225', '1985-07-28','196 Tr???n ?????i Ngh??a, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('88', 'Tr???n Th??nh', '0952424225', '1985-08-29','125 Tr???n ?????i Ngh??a, H?? N???i', 'F');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('89', 'Tr???n Th??nh', '0952434225', '1985-09-23','153 Tr???n ?????i Ngh??a, H?? N???i', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('90', 'Tr???n Vi???t Qu??n', '0952342325', '1995-03-03','154 L?? Du???n, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('91', 'Tr???n Vi???t Qu??n', '0952323225', '1995-04-04','155 L?? Du???n, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('92', 'Tr???n Vi???t Qu??n', '0953464525', '1995-05-05','156 L?? Du???n, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('93', 'Tr???n Vi???t Qu??n', '0956554425', '1995-06-04','157 L?? Du???n, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('94', 'Tr???n Vi???t Qu??n', '0952556425', '1995-07-05','158 L?? Du???n, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('95', 'Tr???n Vi???t Qu??n', '0952564525', '1995-08-06','1 L?? Du???n, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('96', 'Tr???n Vi???t Qu??n', '0952345625', '1995-09-07','653 L?? Du???n, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('97', 'Tr???n Vi???t Qu??n', '0952756425', '1995-01-01','553 L?? Du???n, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('98', 'Tr???n Vi???t Qu??n', '0952345625', '1995-02-02','553 L?? Du???n, H?? Nam', 'M');
INSERT INTO Users(UserID, Ho_va_ten, Sdt, Ngay_sinh, Dia_chi, Gioi_tinh) VALUES ('99', 'Tr???n Vi???t Qu??n', '0952453325', '1995-03-04','653 L?? Du???n, H?? Nam', 'M');

-- Mat hang
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q11', 'Qu???n b??', 'Qu???n ??o', 'Gucci', 145, 190);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q16', 'Qu???n b??', 'Qu???n ??o', 'Calvin Klein', 200, 240);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q17', 'Qu???n b??', 'Qu???n ??o', 'Uniqlo', 210, 230);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q18', 'Qu???n b??', 'Qu???n ??o', 'D&G', 215, 250);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q22', 'Qu???n ????i', 'Qu???n ??o', 'Chanel', 175, 200);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q23', 'Qu???n ????i', 'Qu???n ??o', 'Adidas', 150, 190);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q24', 'Qu???n ????i', 'Qu???n ??o', 'Nike', 200, 220);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q26', 'Qu???n ????i', 'Qu???n ??o', 'Calvin Klein', 130, 180);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q27', 'Qu???n ????i', 'Qu???n ??o', 'Uniqlo', 195, 210);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q28', 'Qu???n ????i', 'Qu???n ??o', 'D&G', 140, 150);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q31', 'Qu???n ??u', 'Qu???n ??o', 'Gucci',225, 265);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q37', 'Qu???n ??u', 'Qu???n ??o', 'Uniqlo', 220, 270);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q38', 'Qu???n ??u', 'Qu???n ??o', 'D&G', 235, 260);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q42', 'Qu???n l??t', 'Qu???n ??o', 'Chanel', 85, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q43', 'Qu???n l??t', 'Qu???n ??o', 'Adidas', 100, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q44', 'Qu???n l??t', 'Qu???n ??o', 'Nike', 90, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q46', 'Qu???n l??t', 'Qu???n ??o', 'Kelvin Calvin', 80, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q48', 'Qu???n l??t', 'Qu???n ??o', 'D&G', 90, 105);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q51', 'Qu???n y???m', 'Qu???n ??o', 'Gucci', 165, 180);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q55', 'Qu???n y???m', 'Qu???n ??o', 'AAA', 145, 170);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('Q57', 'Qu???n y???m', 'Qu???n ??o', 'Uniqlo', 150, 180);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V11', 'V??y b??', 'Qu???n ??o', 'Gucci', 160, 175);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V12', 'V??y b??', 'Qu???n ??o', 'Chanel', 150, 190);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V18', 'V??y b??', 'Qu???n ??o', 'D&G', 100, 130);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V21', 'V??y d??i', 'Qu???n ??o', 'Gucci', 125, 145);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V25', 'V??y d??i', 'Qu???n ??o', 'AAA', 155, 165);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V26', 'V??y d??i', 'Qu???n ??o', 'Calvin Klein', 120, 150);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V34', 'V??y ng???n', 'Qu???n ??o', 'Nike', 100, 125);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('V37', 'V??y ng???n', 'Qu???n ??o', 'Uniqlo', 90, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A12', '??o s?? mi', 'Qu???n ??o', 'Chanel', 575, 600);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A17', '??o s?? mi', 'Qu???n ??o', 'Uniqlo', 735, 750);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A18', '??o s?? mi', 'Qu???n ??o', 'D&G', 800, 825);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A21', '??o kho??c', 'Qu???n ??o', 'Gucci', 875, 915);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A22', '??o kho??c', 'Qu???n ??o', 'Chanel', 920, 970);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A23', '??o kho??c', 'Qu???n ??o', 'Adidas', 850, 875);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A24', '??o kho??c', 'Qu???n ??o', 'Nike', 940, 955);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A25', '??o kho??c', 'Qu???n ??o', 'AAA', 895, 915);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A27', '??o kho??c', 'Qu???n ??o', 'Uniqlo', 800, 835);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A28', '??o kho??c', 'Qu???n ??o', 'D&G', 995, 1005);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A31', '??o ph??ng', 'Qu???n ??o', 'Gucci', 310, 325);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A32', '??o ph??ng', 'Qu???n ??o', 'Chanel', 275, 300);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A33', '??o ph??ng', 'Qu???n ??o', 'Adidas', 250, 295);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A34', '??o ph??ng', 'Qu???n ??o', 'Nike', 295, 315);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A36', '??o ph??ng', 'Qu???n ??o', 'Calvin Klein', 300, 325);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A37', '??o ph??ng', 'Qu???n ??o', 'Uniqlo', 350, 375);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A38', '??o ph??ng', 'Qu???n ??o', 'D&G', 310, 350);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A41', '??o croptop', 'Qu???n ??o', 'Gucci', 70, 90);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A43', '??o croptop', 'Qu???n ??o', 'Adidas', 70, 95);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A44', '??o croptop', 'Qu???n ??o', 'Nike', 80, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A45', '??o croptop', 'Qu???n ??o', 'AAA', 90, 105);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A48', '??o croptop', 'Qu???n ??o', 'D&G', 95, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A54', '??o ba l???', 'Qu???n ??o', 'Nike', 100, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A57', '??o ba l???', 'Qu???n ??o', 'Uniqlo', 115, 130);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A58', '??o ba l???', 'Qu???n ??o', 'D&G', 120, 150);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A62', '??o t???m', 'Qu???n ??o', 'Chanel', 180, 200);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A63', '??o t???m', 'Qu???n ??o', 'Chanel', 160, 210);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A66', '??o t???m', 'Qu???n ??o', 'Calvin Klein', 170, 230);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A68', '??o t???m', 'Qu???n ??o', 'D&G', 200, 220);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A71', '??o l??t', 'Qu???n ??o', 'Gucci', 185, 205);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A73', '??o l??t', 'Qu???n ??o', 'Adidas', 170, 195);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A74', '??o l??t', 'Qu???n ??o', 'Nike', 190, 215);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A77', '??o l??t', 'Qu???n ??o', 'Uniqlo', 190, 205);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A83', '??o ch???ng n???ng', 'Qu???n ??o', 'Adidas', 235, 250);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A84', '??o ch???ng n???ng', 'Qu???n ??o', 'Nike', 190, 210);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A85', '??o ch???ng n???ng', 'Qu???n ??o', 'AAA', 180, 205);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('A87', '??o ch???ng n???ng', 'Qu???n ??o', 'Uniqlo', 250, 265);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G13', 'Gi??y th??? thao', 'Gi??y d??p', 'Adidas', 970, 1010);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G14', 'Gi??y th??? thao', 'Gi??y d??p', 'Nike', 1055, 1100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G15', 'Gi??y th??? thao', 'Gi??y d??p', 'AAA', 890, 950);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G24', 'Gi??y l?????i', 'Gi??y d??p', 'Nike', 515, 565);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G25', 'Gi??y l?????i', 'Gi??y d??p', 'AAA', 450, 485);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G27', 'Gi??y l?????i', 'Gi??y d??p', 'Uniqlo', 470, 500);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G33', 'Gi??y bata', 'Gi??y d??p', 'Adidas', 45, 50);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G34', 'Gi??y bata', 'Gi??y d??p', 'Nike', 35, 65);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G41', 'Gi??y cao g??t', 'Gi??y d??p', 'Gucci', 730, 765);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G42', 'Gi??y cao g??t', 'Gi??y d??p', 'Chanel', 675, 700);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G46', 'Gi??y cao g??t', 'Gi??y d??p', 'Calvin Klein', 750, 770);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('G48', 'Gi??y cao g??t', 'Gi??y d??p', 'D&G', 765, 800);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D12', 'D??p t??ng', 'Gi??y d??p', 'Chanel', 55, 70);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D18', 'D??p t??ng', 'Gi??y d??p', 'D&G', 50, 55);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D21', 'D??p croc', 'Gi??y d??p', 'Gucci', 85, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D22', 'D??p croc', 'Gi??y d??p', 'Chanel', 90, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D25', 'D??p croc', 'Gi??y d??p', 'AAA', 85, 105);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D28', 'D??p croc', 'Gi??y d??p', 'D&G', 90, 115);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D31', 'D??p t??? ong', 'Gi??y d??p', 'Gucci', 65, 70);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D32', 'D??p t??? ong', 'Gi??y d??p', 'Chanel', 70, 80);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D44', 'D??p cao su', 'Gi??y d??p', 'Nike', 95, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D46', 'D??p cao su', 'Gi??y d??p', 'Calvin Klein', 105, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('D45', 'D??p cao su', 'Gi??y d??p', 'Nike', 100, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M13', 'M?? l?????i trai', 'M?? n??n', 'Adidas', 50, 55);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M14', 'M?? l?????i trai', 'M?? n??n', 'Nike', 45, 60);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M16', 'M?? l?????i trai', 'M?? n??n', 'Calvin Klein', 45, 50);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M21', 'M?? r???ng v??nh', 'M?? n??n', 'Gucci', 60, 70);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M22', 'M?? r???ng v??nh', 'M?? n??n', 'Chanel', 55, 75);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M28', 'M?? r???ng v??nh', 'M?? n??n', 'D&G', 60, 80);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M32', 'M?? cao b???i', 'M?? n??n', 'Chanel', 105, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M35', 'M?? cao b???i', 'M?? n??n', 'AAA', 110, 125);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M37', 'M?? cao b???i', 'M?? n??n', 'Uniqlo', 95, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M45', 'M?? b???o hi???m', 'M?? n??n', 'AAA', 115, 130);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M47', 'M?? b???o hi???m', 'M?? n??n', 'Uniqlo', 120, 135);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M51', 'M?? len', 'M?? n??n', 'Gucci', 70, 80);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M52', 'M?? len', 'M?? n??n', 'Chanel', 75, 85);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M57', 'M?? len', 'M?? n??n', 'Uniqlo', 80, 95);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M58', 'M?? len', 'M?? n??n', 'D&G', 80, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M66', 'M?? panama', 'M?? n??n', 'Calvin Klein', 185, 200);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M67', 'M?? panama', 'M?? n??n', 'D&G', 190, 210);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M72', 'M?? beret', 'M?? n??n', 'Chanel', 100, 115);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M75', 'M?? beret', 'M?? n??n', 'AAA', 100, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M86', 'M?? fedora', 'M?? n??n', 'Calvin Klein', 105, 130);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M87', 'M?? fedora', 'M?? n??n', 'Uniqlo', 110, 135);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('M88', 'M?? fedora', 'M?? n??n', 'D&G', 90, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T11', 'T??i ch??? nh???t', 'T??i x??ch', 'Gucci', 1900, 1955);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T12', 'T??i ch??? nh???t', 'T??i x??ch', 'Chanel', 1985, 2000);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T18', 'T??i ch??? nh???t', 'T??i x??ch', 'D&G', 1995, 2005);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T23', 'T??i ba l??', 'T??i x??ch', 'Adidas', 1930, 1950);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T24', 'T??i ba l??', 'T??i x??ch', 'Nike', 1800, 1840);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T26', 'T??i ba l??', 'T??i x??ch', 'Calvin Klein', 1930, 1950);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T32', 'T??i tote', 'T??i x??ch', 'Chanel', 40, 50);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T37', 'T??i tote', 'T??i x??ch', 'Uniqlo', 45, 60);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T41', 'T??i pucket', 'T??i x??ch', 'Gucci', 85, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T46', 'T??i pucket', 'T??i x??ch', 'Calvin Klein', 120, 130);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T48', 'T??i pucket', 'T??i x??ch', 'D&G', 115, 145);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T55', 'T??i clutch', 'T??i x??ch', 'AAA', 120, 155);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T58', 'T??i clutch', 'T??i x??ch', 'D&G', 120, 140);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T62', 'T??i crossbody', 'T??i x??ch', 'Chanel', 235, 250);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('T65', 'T??i crossbody', 'T??i x??ch', 'AAA', 215, 255);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P11', 'Hoa tai h??nh hoa', 'Ph??? ki???n', 'Gucci', 25, 30);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P12', 'Hoa tai h??nh hoa', 'Ph??? ki???n', 'Chanel', 40, 45);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P23', 'Hoa tai h??nh n?????c', 'Ph??? ki???n', 'Adidas', 30, 35);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P25', 'Hoa tai h??nh n?????c', 'Ph??? ki???n', 'AAA', 20, 30);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P31', 'Hoa tai qu??? t??o', 'Ph??? ki???n', 'Gucci', 25, 30);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P37', 'Hoa tai qu??? t??o', 'Ph??? ki???n', 'Uniqlo', 20, 45);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P41', 'K??nh r??m', 'Ph??? ki???n', 'Gucci', 15, 35);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P42', 'K??nh r??m', 'Ph??? ki???n', 'Chanel', 35, 40);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P47', 'K??nh r??m', 'Ph??? ki???n', 'Uniqlo', 45, 50);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P48', 'K??nh r??m', 'Ph??? ki???n', 'D&G', 50, 55);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P57', 'G???ng k??nh', 'Ph??? ki???n', 'Uniqlo', 30, 35);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P58', 'G???ng k??nh', 'Ph??? ki???n', 'D&G', 50, 60);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P61', '?????ng h??? nam', 'Ph??? ki???n', 'Gucci', 850, 875);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P67', '?????ng h??? nam', 'Ph??? ki???n', 'Uniqlo', 880, 900);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P68', '?????ng h??? nam', 'Ph??? ki???n', 'D&G', 900, 925);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P71', '?????ng h??? n???', 'Ph??? ki???n', 'Gucci', 850, 875);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P72', '?????ng h??? n???', 'Ph??? ki???n', 'Chanel', 970, 990);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P82', 'C?? v???t', 'Ph??? ki???n', 'Chanel', 300, 345);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P85', 'C?? v???t', 'Ph??? ki???n', 'AAA', 320, 350);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P87', 'C?? v???t', 'Ph??? ki???n', 'Uniqlo', 345, 360);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P92', 'N?????c hoa', 'Ph??? ki???n', 'Chanel', 1150, 1200);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P94', 'N?????c hoa', 'Ph??? ki???n', 'Nike', 1105, 1150);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P96', 'C?? v???t', 'Ph??? ki???n', 'Calvin Klein', 1285, 1300);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P101', 'Gang tay', 'Ph??? ki???n', 'Gucci', 90, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P102', 'Gang tay', 'Ph??? ki???n', 'Chanel', 100, 120);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P113', 'T???t c??? d??i', 'Ph??? ki???n', 'Adidas', 15, 20);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P114', 'T???t c??? d??i', 'Ph??? ki???n', 'Nike', 20, 25);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P118', 'T???t c??? d??i', 'Ph??? ki???n', 'D&G', 25, 30);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P123', 'T???t c??? ng???n', 'Ph??? ki???n', 'Adidas', 10, 15);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P124', 'T???t c??? ng???n', 'Ph??? ki???n', 'Nike', 15, 20);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P125', 'T???t c??? ng???n', 'Ph??? ki???n', 'AAA', 10, 15);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P133', '??', 'Ph??? ki???n', 'Adidas', 55, 60);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P134', '??', 'Ph??? ki???n', 'Nike', 60, 70);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P135', '??', 'Ph??? ki???n', 'AAA', 75, 80);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P141', 'Ghim c??i ??o', 'Ph??? ki???n', 'Gucci', 90, 100);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P142', 'Ghim c??i ??o', 'Ph??? ki???n', 'Chanel', 100, 110);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P146', 'Ghim c??i ??o', 'Ph??? ki???n', 'Calvin Klein', 110, 115);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P147', 'Ghim c??i ??o', 'Ph??? ki???n', 'Uniqlo', 100, 125);
INSERT INTO MatHang(Ma_hang, Ten, Danh_muc, Thuong_hieu, Gia_nhap_vao, Gia_ban) VALUES ('P148', 'Ghim c??i ??o', 'Ph??? ki???n', 'D&G', 150, 165);

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
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID) VALUES ('MD1', 'Giao h??ng th??nh c??ng','Online', '2022-05-23', '6' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD2', 'Giao h??ng th??nh c??ng','Online', '2022-06-23', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD3', 'Giao h??ng th??nh c??ng','Online', '2022-07-23', '8' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD4', 'Giao h??ng th??nh c??ng','Online', '2022-08-21', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD5', 'Giao h??ng th??nh c??ng','Online', '2022-09-21', '10' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD6', 'Giao h??ng th??nh c??ng','Online', '2022-12-26', '4' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD7', 'Giao h??ng th??nh c??ng','Online', '2022-11-27', '5' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD8', 'Giao h??ng th??nh c??ng','Online', '2022-11-28', '1' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD9', 'Giao h??ng th??nh c??ng','Online', '2022-11-29', '3' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD10', 'Giao h??ng th??nh c??ng','Online', '2022-11-24', '4' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD11', 'Giao h??ng th??nh c??ng','Online', '2022-12-25', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD12', 'Giao h??ng th??nh c??ng','Online', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD13', 'Giao h??ng th??nh c??ng','Ti???n m???t', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD14', 'Giao h??ng th??nh c??ng','Ti???n m???t', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD15', 'Giao h??ng th??nh c??ng','Ti???n m???t', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD16', 'Giao h??ng th??nh c??ng','Ti???n m???t', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD17', 'Giao h??ng th??nh c??ng','Ti???n m???t', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD18', 'Giao h??ng th??nh c??ng','Ti???n m???t', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD19', 'Giao h??ng th??nh c??ng','Ti???n m???t', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD20', 'Giao h??ng th??nh c??ng','Ti???n m???t', '2022-12-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD21', '??ang giao h??ng','Ti???n m???t', '2022-02-05', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD22', '??ang giao h??ng','Ti???n m???t', '2022-07-06', '10' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD23', '??ang giao h??ng','Ti???n m???t', '2022-08-07', '11' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD24', '??ang giao h??ng','Ti???n m???t', '2022-09-08', '13' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD25', '??ang giao h??ng','Ti???n m???t', '2022-01-08', '14' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD26', '??ang giao h??ng','Ti???n m???t', '2022-02-02', '16' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD27', '??ang giao h??ng','Ti???n m???t', '2022-03-15', '16' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD28', '??ang giao h??ng','Ti???n m???t', '2022-04-15', '54' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD29', '??ang giao h??ng','Ti???n m???t', '2022-02-15', '23' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD30', 'B??? h???y','Ti???n m???t', '2022-02-14', '23' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD31', 'B??? h???y','Ti???n m???t', '2022-01-15', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD32', 'B??? h???y','Ti???n m???t', '2022-03-16', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD33', 'B??? h???y','Ti???n m???t', '2022-04-17', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD34', 'B??? h???y','Ti???n m???t', '2022-05-18', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD35', 'B??? h???y','Ti???n m???t', '2022-06-19', '23' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD36', 'B??? h???y','Ti???n m???t', '2022-02-10', '46' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD37', 'B??? h???y','Ti???n m???t', '2022-08-12', '78' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD38', 'B??? h???y','Ti???n m???t', '2022-09-12', '86' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD39', 'B??? h???y','Ti???n m???t', '2022-10-16', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD40', '???? ph?? duy???t','Online', '2022-11-16', '44' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD41', '???? ph?? duy???t','Online', '2022-12-12', '23' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD42', '???? ph?? duy???t','Online', '2022-01-13', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD43', '???? ph?? duy???t','Online', '2022-11-14', '76' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD44', '???? ph?? duy???t','Online', '2022-11-15', '75' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD45', '???? ph?? duy???t','Online', '2022-10-16', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD46', '???? ph?? duy???t','Online', '2022-12-17', '65' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD47', '???? ph?? duy???t','Online', '2022-10-18', '21' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD48', '???? ph?? duy???t','Online', '2022-12-16', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD49', '???? ph?? duy???t','Online', '2022-10-16', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD50', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-12-21', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD51', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-11-22', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD52', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-10-23', '26' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD53', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-10-26', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD54', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-11-24', '46' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD55', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-10-25', '53' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD56', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-12-26', '63' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD57', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-11-17', '53' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD58', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-11-27', '53' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD59', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-11-16', '57' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD60', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2021-01-02', '54' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD61', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2021-02-03', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD62', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2021-03-04', '54' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD63', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2021-04-05', '65' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD64', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2021-05-06', '74' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD65', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2021-06-07', '86' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD66', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2021-07-08', '91' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD67', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2021-08-09', '32' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD68', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2021-09-01', '78' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD69', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2021-03-03', '84' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD70', '??ang giao h??ng','Online', '2021-03-03', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD71', '??ang giao h??ng','Online', '2021-04-03', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD72', '??ang giao h??ng','Online', '2021-05-03', '32' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD73', '??ang giao h??ng','Online', '2021-06-03', '43' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD74', '??ang giao h??ng','Online', '2021-06-03', '65' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD75', '??ang giao h??ng','Online', '2021-07-03', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD76', '??ang giao h??ng','Online', '2021-08-03', '64' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD77', '??ang giao h??ng','Online', '2021-09-03', '56' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD78', '??ang giao h??ng','Online', '2021-01-03', '67' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD79', '??ang giao h??ng','Online', '2021-04-03', '87' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD80', 'Ch??? ph?? duy???t','Online', '2021-04-01', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD81', 'Ch??? ph?? duy???t','Online', '2021-01-02', '23' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD82', 'Ch??? ph?? duy???t','Online', '2021-02-03', '4' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD83', 'Ch??? ph?? duy???t','Online', '2021-04-04', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD84', 'Ch??? ph?? duy???t','Online', '2021-05-05', '47' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD85', 'Ch??? ph?? duy???t','Online', '2021-06-06', '57' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD86', 'Ch??? ph?? duy???t','Online', '2021-07-07', '67' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD87', 'Ch??? ph?? duy???t','Online', '2021-08-08', '27' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD88', 'Ch??? ph?? duy???t','Online', '2021-09-03', '57' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD89', 'Ch??? ph?? duy???t','Online', '2021-07-04', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD90', 'Ch??? ph?? duy???t','Ti???n m???t', '2021-03-03', '1' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD91', 'Ch??? ph?? duy???t','Ti???n m???t', '2021-05-04', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD92', 'Ch??? ph?? duy???t','Ti???n m???t', '2021-04-05', '47' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD93', 'Ch??? ph?? duy???t','Ti???n m???t', '2021-06-06', '57' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD94', 'Ch??? ph?? duy???t','Ti???n m???t', '2021-07-07', '67' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD95', 'Ch??? ph?? duy???t','Ti???n m???t', '2021-09-08', '37' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD96', 'Ch??? ph?? duy???t','Ti???n m???t', '2021-07-09', '37' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD97', 'Ch??? ph?? duy???t','Ti???n m???t', '2021-01-05', '87' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD98', 'Ch??? ph?? duy???t','Ti???n m???t', '2021-04-03', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD99', 'Ch??? ph?? duy???t','Ti???n m???t', '2021-07-01', '97' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD100', '???? ph?? duy???t','Online', '2021-01-11', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD101', '???? ph?? duy???t','Online', '2021-01-10', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD102', 'B??? h???y','Online', '2020-01-14', '4' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD103', 'B??? h???y','Online', '2020-04-14', '3' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD104', 'B??? h???y','Online', '2020-05-14', '4' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD105', 'B??? h???y','Online', '2020-06-13', '5' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD106', 'B??? h???y','Online', '2020-07-15', '6' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD107', 'B??? h???y','Online', '2020-08-16', '7' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD108', 'B??? h???y','Online', '2020-03-17', '8' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD109', 'B??? h???y','Online', '2020-04-18', '8' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD110', 'B??? h???y','Online', '2020-05-19', '9' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD111', 'B??? h???y','Ti???n m???t', '2020-05-14', '90' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD112', 'B??? h???y','Ti???n m???t', '2020-05-12', '91' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD113', 'B??? h???y','Ti???n m???t', '2020-05-14', '94' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD114', 'B??? h???y','Ti???n m???t', '2020-05-15', '5' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD115', 'B??? h???y','Ti???n m???t', '2020-05-13', '54' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD116', 'B??? h???y','Ti???n m???t', '2020-05-16', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD117', 'B??? h???y','Ti???n m???t', '2020-05-15', '57' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD118', 'B??? h???y','Ti???n m???t', '2020-05-18', '76' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD119', 'B??? h???y','Ti???n m???t', '2020-05-19', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD120', '??ang giao h??ng','Ti???n m???t', '2020-09-14', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD121', '??ang giao h??ng','Ti???n m???t', '2020-08-13', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD122', '??ang giao h??ng','Ti???n m???t', '2020-07-12', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD123', '??ang giao h??ng','Ti???n m???t', '2020-06-13', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD124', '??ang giao h??ng','Ti???n m???t', '2020-06-12', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD125', '??ang giao h??ng','Ti???n m???t', '2020-03-09', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD126', '??ang giao h??ng','Ti???n m???t', '2020-03-09', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD127', '??ang giao h??ng','Ti???n m???t', '2020-02-09', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD128', '??ang giao h??ng','Ti???n m???t', '2020-07-09', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD129', '??ang giao h??ng','Ti???n m???t', '2020-06-13', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD130', '??ang giao h??ng','Ti???n m???t', '2020-06-14', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD131', '??ang giao h??ng','Ti???n m???t', '2020-05-12', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD132', '??ang giao h??ng','Ti???n m???t', '2020-04-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD133', '??ang giao h??ng','Ti???n m???t', '2020-02-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD134', '??ang giao h??ng','Ti???n m???t', '2020-01-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD135', '??ang giao h??ng','Ti???n m???t', '2020-09-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD136', '??ang giao h??ng','Ti???n m???t', '2020-08-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD137', '??ang giao h??ng','Ti???n m???t', '2020-07-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD138', '??ang giao h??ng','Ti???n m???t', '2020-06-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD139', '??ang giao h??ng','Ti???n m???t', '2020-05-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD140', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD141', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '14' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD142', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD143', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD144', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '55' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD145', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '5' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD146', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD147', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '75' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD148', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '75' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD149', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '85' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD150', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '95' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD151', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '15' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD152', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '25' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD153', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '35' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD154', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '45' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD155', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '55' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD156', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '16' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD157', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '16' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD158', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '16' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD159', 'Giao h??ng kh??ng th??nh c??ng','Ti???n m???t', '2020-04-12', '1' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD160', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-05-14', '1' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD161', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-05-14', '61' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD162', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-05-14', '12' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD163', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-05-14', '62' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD164', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-05-14', '34' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD165', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-05-14', '61' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD166', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-05-14', '51' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD167', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-05-14', '71' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD168', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-05-14', '81' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD169', 'Giao h??ng kh??ng th??nh c??ng','Online', '2022-05-14', '91' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD170', '??ang giao h??ng','Online', '2022-05-16', '13' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD171', '??ang giao h??ng','Online', '2022-05-17', '14' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD172', '??ang giao h??ng','Online', '2022-05-18', '31' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD173', '??ang giao h??ng','Online', '2022-05-19', '1' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD174', '??ang giao h??ng','Online', '2022-05-21', '41' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD175', '??ang giao h??ng','Online', '2022-05-23', '41' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD176', '??ang giao h??ng','Online', '2022-05-11', '11' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD177', '??ang giao h??ng','Online', '2022-05-12', '61' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD178', '??ang giao h??ng','Online', '2022-05-23', '71' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD179', '??ang giao h??ng','Online', '2022-05-05', '81' );
INSERT INTO Don_hang(Ma_don, Tinh_trang_don, Hinh_thuc_thanh_toan, Ngay_dat_hang, UserID)VALUES ('MD180', '??ang giao h??ng','Online', '2022-05-09', '91' );

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
	if (lower(NEW.Tinh_trang_don) = '???? ph?? duy???t') then
        update Kho set So_luong_thuc_te = So_luong_thuc_te - x.So_luong where ma_kho ='1' ;
    end if;
    if (lower(NEW.Tinh_trang_don) = 'b??? h???y') then
        update Kho set So_luong_thuc_te = So_luong_thuc_te + x.So_luong where ma_kho ='2' ;
    end if;
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER afup_Don_hang
AFTER UPDATE ON Don_hang
FOR EACH ROW
WHEN (lower(NEW.Tinh_trang_don) = '???? ph?? duy???t' OR lower(NEW.Tinh_trang_don) = 'b??? h???y')
EXECUTE PROCEDURE afup_Don_hang();