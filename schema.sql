CREATE TABLE IF NOT EXISTS patients (
  cns        bigint(15)    ZEROFILL NOT NULL UNIQUE,
  cpf        bigint(11)    ZEROFILL NOT NULL UNIQUE,
  name       varchar(128)  NOT NULL,
  birth      date          NOT NULL,
  mother     varchar(128)  NOT NULL,
  area       tinyint(2)    ZEROFILL NOT NULL,
  microarea  tinyint(2)    ZEROFILL NOT NULL,
  family     tinyint(3)    ZEROFILL NOT NULL,
  address    varchar(256)  NOT NULL,
  cep        mediumint(8)  ZEROFILL NOT NULL,
  phone      bigint(11)    ZEROFILL NOT NULL,
  notes      mediumtext,
  PRIMARY KEY  (cns)
) $charset_collate;

CREATE TABLE IF NOT EXISTS psy_group (
  id         int(4)      ZEROFILL NOT NULL UNIQUE AUTO_INCREMENT,
  cns        bigint(15)  ZEROFILL NOT NULL,
  adding     date        NOT NULL,
  leaving    date        NOT NULL,
  diagnosis  varchar(4)  NOT NULL,
  PRIMARY KEY  (id),
  FOREIGN KEY (cns) REFERENCES patients(cns)
) $charset_collate;

CREATE TABLE IF NOT EXISTS psy_meds (
  id            int(9)       ZEROFILL NOT NULL UNIQUE AUTO_INCREMENT,
  patient       int(4)       ZEROFILL NOT NULL,
  name          varchar(64)  NOT NULL,
  posology      varchar(16)  NOT NULL,
  presentation  varchar(16)  NOT NULL,
  dispensation  smallint(6)  ZEROFILL NOT NULL,
  subscript     tinytext     NOT NULL,
  PRIMARY KEY  (id),
  FOREIGN KEY (patient) REFERENCES psy_group(id)
) $charset_collate;

CREATE TABLE IF NOT EXISTS pregnants (
  id                   int(4)       ZEROFILL NOT NULL UNIQUE AUTO_INCREMENT,
  sis_pn               bigint(15)   ZEROFILL NOT NULL UNIQUE,
  cns                  bigint(15)   ZEROFILL NOT NULL,
  adding               date         NOT NULL,
  leaving              date         NOT NULL,
  lmp                  date         NOT NULL,
  us_date              date         NOT NULL,
  us_weeks             tinyint(2)   ZEROFILL NOT NULL,
  us_days              tinyint(1)   ZEROFILL NOT NULL,
  pregnancies          tinyint(2)   ZEROFILL NOT NULL,
  normal_births        tinyint(2)   ZEROFILL NOT NULL,
  csec_births          tinyint(2)   ZEROFILL NOT NULL,
  forc_births          tinyint(2)   ZEROFILL NOT NULL,
  abortions            tinyint(2)   ZEROFILL NOT NULL,
  curettages           tinyint(2)   ZEROFILL NOT NULL,
  last_preg            tinyint(2)   ZEROFILL NOT NULL,
  willing              boolean      NOT NULL DEFAULT FALSE,
  height               tinyint(3)   NOT NULL,
  start_weight         float(1)     NOT NULL,
  /* Risks and Stuff */
  risk_low_age         boolean      NOT NULL DEFAULT false,
  risk_high_age        boolean      NOT NULL DEFAULT false,
  risk_stillborn       boolean      NOT NULL DEFAULT false,
  risk_diabetes        boolean      NOT NULL DEFAULT false,
  risk_hypertension    boolean      NOT NULL DEFAULT false,
  risk_smoker          boolean      NOT NULL DEFAULT false,
  risk_alcohol         boolean      NOT NULL DEFAULT false,
  risk_drugs           boolean      NOT NULL DEFAULT false,
  risk_low_income      boolean      NOT NULL DEFAULT false,
  risk_low_study       boolean      NOT NULL DEFAULT false,
  risk_ocupation       boolean      NOT NULL DEFAULT false,
  special_hiv          boolean      NOT NULL DEFAULT false,
  special_syphilis     boolean      NOT NULL DEFAULT false,
  special_toxo         boolean      NOT NULL DEFAULT false,
  special_multiple     boolean      NOT NULL DEFAULT false,
  special_misser       boolean      NOT NULL DEFAULT false,
  special_labmisser    boolean      NOT NULL DEFAULT false,
  /* Special Labs */
  mother_abo           varchar(2),
  mother_rh            varchar(1),
  father_abo           varchar(2),
  father_rh            varchar(1),
  cco_date             date,
  cco_result           boolean,
  pegb_date            date,
  pegb_result          boolean,
  /* 1st Trimester */
  tri1_date            date,
  tri1_vdrl            tinyint(3)   UNSIGNED,
  tri1_hiv             tinyint(3)   UNSIGNED,
  tri1_hbsag           tinyint(3)   UNSIGNED,
  tri1_hcv             tinyint(3)   UNSIGNED,
  tri1_toxo_igm        tinyint(3)   UNSIGNED,
  tri1_toxo_igg        tinyint(3)   UNSIGNED,
  tri1_hb              float(1)     UNSIGNED,
  tri1_ht              tinyint(3)   UNSIGNED,
  tri1_eas             tinyint(1)   UNSIGNED,
  tri1_uroc            varchar(128),
  tri1_glic            tinyint(3)   UNSIGNED,
  tri1_tsh             float(2)     UNSIGNED,
  tri1_t4l             float(2)     UNSIGNED,
  tri1_ppf             varchar(128),
  /* 2nd Trimester */
  tri2_date            date,
  tri2_vdrl            tinyint(3)   UNSIGNED,
  tri2_hiv             tinyint(3)   UNSIGNED,
  tri2_toxo_igm        tinyint(3)   UNSIGNED,
  tri2_toxo_igg        tinyint(3)   UNSIGNED,
  tri2_glic            tinyint(3)   UNSIGNED,
  tri2_eas             tinyint(1)   UNSIGNED,
  tri2_uroc            varchar(128),
  tri2_tsh             float(2)     UNSIGNED,
  tri2_t4l             float(2)     UNSIGNED,
  /* 3rd Trimester */
  tri3_date            date,
  tri3_vdrl            tinyint(3)   UNSIGNED,
  tri3_hiv             tinyint(3)   UNSIGNED,
  tri3_toxo_igm        tinyint(3)   UNSIGNED,
  tri3_toxo_igg        tinyint(3)   UNSIGNED,
  tri3_glic            tinyint(3)   UNSIGNED,
  tri3_eas             tinyint(1)   UNSIGNED,
  tri3_uroc            varchar(128),
  tri3_tsh             float(2)     UNSIGNED,
  tri3_t4l             float(2)     UNSIGNED,
  /* Delivery/Closing */
  delivery_date        date,
  delivery_type        varchar(32),
  delivery_place       varchar(32),
  delivery_episio      boolean,
  delivery_rupture     varchar(16),
  delivery_anaestesia  varchar(16),
  delivery_leave_w_nb  boolean,
  delivery_notes       mediumtext,
  PRIMARY KEY  (id),
  FOREIGN KEY (cns) REFERENCES patients(cns)
) $charset_collate;

CREATE TABLE IF NOT EXISTS preg_rh (
  id            int(9)    ZEROFILL NOT NULL UNIQUE AUTO_INCREMENT,
  patient       int(4)    ZEROFILL NOT NULL,
  coombs_date   date      NOT NULL,
  coombs        boolean   NOT NULL DEFAULT false,
  rhogam        date      DEFAULT NULL,
  PRIMARY KEY  (id),
  FOREIGN KEY (patient) REFERENCES pregnants(id)
) $charset_collate;

CREATE TABLE IF NOT EXISTS preg_syph_treat (
  id        int(9)          ZEROFILL NOT NULL UNIQUE AUTO_INCREMENT,
  patient   int(4)          ZEROFILL NOT NULL,
  admin     date            NOT NULL,
  drug      varchar(64)     NOT NULL,
  dose      mediumint(10)   UNSIGNED NOT NULL,
  unit      varchar(2)      NOT NULL,
  PRIMARY KEY  (id),
  FOREIGN KEY (patient) REFERENCES pregnants(id)
) $charset_collate;

CREATE TABLE IF NOT EXISTS preg_syph_vdrl (
  id           int(9)        ZEROFILL NOT NULL UNIQUE AUTO_INCREMENT,
  patient      int(4)        ZEROFILL NOT NULL,
  vdrl_date    date          NOT NULL,
  vrdl_title   smallint(4)   UNSIGNED NOT NULL,
  treponemic   boolean       NOT NULL,
  tpha         boolean,
  PRIMARY KEY  (id),
  FOREIGN KEY (patient) REFERENCES pregnants(id)
) $charset_collate;

CREATE TABLE IF NOT EXISTS tuberculosis (
  id int(4) ZEROFILL NOT NULL UNIQUE AUTO_INCREMENT,
  cns bigint(15) ZEROFILL NOT NULL,
  adding date NOT NULL,
  leaving date NOT NULL,
) $charset_collate;
