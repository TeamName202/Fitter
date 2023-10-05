-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 3.34.50.142    Database: fitter
-- ------------------------------------------------------
-- Server version	8.0.34-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `box`
--

DROP TABLE IF EXISTS `box`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `box` (
  `id` int NOT NULL AUTO_INCREMENT,
  `box_name` varchar(50) DEFAULT NULL,
  `box_address` varchar(100) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `box`
--

LOCK TABLES `box` WRITE;
/*!40000 ALTER TABLE `box` DISABLE KEYS */;
INSERT INTO `box` VALUES (1,'크린이','자택',NULL),(2,'CrossFit Able','32 songpa-dong songpa-gu Seoul',NULL),(3,'CrossFit Maru','1-57_ B1_ Dongsung-dong_ Jongno-gu Seoul',NULL),(4,'CrossFit Sound Wave','B1 471_ Suyeong-ro Suyeong-gu',NULL),(5,'CrossFit 032','151-7 Gojan-dong Namdong-gu',NULL),(6,'CrossFit Zest','14-8 Yangjae-dong_ Seocho-Gu Seoul',NULL),(7,'CrossFit SteamPunk','B1F_ 22-3_ Yonsei-ro 5da-gil Seoul',NULL),(8,'CrossFit HIM','77_ Heungan-daero 439beon-gil_ Dongan-gu Anyang-Si',NULL),(9,'Muhan CrossFit','174-18_ Yeomni-dong_ Mapo-gu Seoul',NULL),(10,'Songdo CrossFit','3-31_ Songdo-dong Yeonsu-gu',NULL),(11,'R2G CrossFit','B1_ 256_ Jungdong-ro_ Wonmi-gu Bucheon-si',NULL),(12,'CrossFit Jjang','100-13_ 527 Beongil_ DongBaekJukJeonDaeRo Yonginsi',NULL),(13,'CrossFit Hot Place','1035_ Ingye-Dong_ Paldal-Gu Suwon-Si',NULL),(14,'CrossFit RAON','B1_ 294_ Achasan-ro Gwangjin-gu',NULL),(15,'CrossFit Believable','204-8_ Samsandong Ulsan',NULL),(16,'CrossFit Maha','134-3_ Jakjeon-dong_ Gyeyang-gu Incheon',NULL),(17,'CrossFit JiCo','B1F_ 2510_ Dalgubeol-daero Daegu',NULL),(18,'CrossFit Balsan','678-13 B1_ Deungchon 3-dong_ Gangseo-gu_ Seoul_ Korea Seoul',NULL),(19,'CrossFit Doklip','B1_987_Dujeong-dong Seobuk-gu Cheonan-Si',NULL),(20,'CrossFit A4U','5-9_ Cheongna ruby-ro 42beon-gil_ Seo-gu Incheon',NULL),(21,'CrossFit GUTS','B1_ Daemyoung Green Plaza_ 463_ Sang-dong Bucheon-si',NULL),(22,'CrossFit Shout','5F ilsung IS Mart 657 Ssangyongdong Cheonan-si',NULL),(23,'CrossFit Juan','100_ Juan-ro_ Nam-gu_ Incheon_ Korea Incheon',NULL),(24,'Golden Crown CrossFit','1329-4_ Seocho-dong Seocho-gu',NULL),(25,'Poss CrossFit','344-1_Daebang-dong Dongjak-gu',NULL),(26,'CrossFit Hoya','22_ Seomun-daero 556beon-gil_ Nam-gu Gwangju',NULL),(27,'CrossFit MATE','B1_120_ Dongcheon-ro_ Yongin-si_',NULL),(28,'CrossFit Volcano','B1 Duksan Bldg._ Dogok-Ro 450 Seoul',NULL),(29,'CrossFit Hwajeong','961_ Hwajeong-dong_ Deogyang-gu Goyang-si',NULL),(30,'CrossFit Sanbon','1061 Sanbon-dong Gunpo-city',NULL),(31,'CrossFit Cheongna','4_ Boseok-ro Incheon',NULL),(32,'CrossFit Shooting Star','42_ Gyeonginyet-ro Bucheon-si',NULL),(33,'CrossFit SuperBomb','Jong-ro 1-gil 42_ Seoul',NULL),(34,'CrossFit Baekho','480_ Gwanak-daero_ Dongan-gu Anyang-si_',NULL),(35,'CrossFit VS','B1_ 37_ Yonsei-ro 9-gil Seoul',NULL),(36,'CrossFit Cheon','2_ Chilseong-ro 6-gil Jecheon-si',NULL),(37,'CrossFit Rikka','39 Namnyeong-ro Jeju-si',NULL),(38,'CrossFit Baro','38_ Jungang-daero 692beon-gil Busanjin-Gu',NULL),(39,'Golden Crown CrossFit Seodaemun','8_ Jeongdong-gil_ Jung-gu Seoul',NULL),(40,'CrossFit Alright','17_ Singal-ro_ 58 Beon-gil_ Giheung-gu Yongin-si',NULL),(41,'CrossFit DE','80_Daeeun-ro Siheung-si',NULL),(42,'CrossFit Buff','55_ Gugal-ro_ Giheung-gu Yongin-si',NULL),(43,'CrossFit PALPAL','551-10 B1 Daejeon',NULL),(44,'CrossFit Igong','8_ Dasa-ro 4-gil_ Dasa-eup_ Dalseong-gun Daegu',NULL),(45,'G9 CrossFit','73 Jangdeung-ro_ Sincheon-dong_ Dong-gu_ Daegu Dong-gu',NULL),(46,'CrossFit Hound','166_ Songi-ro Songpa-gu',NULL),(47,'CrossFit Noeun Elite Gym','13-38_ Eungubinam-ro 33 Beon-gil_ Yuseong-gu Daejeon',NULL),(48,'CrossFit Fairy','42_ Anyang-ro 532beon-gil Manan-gu_ Anyang-si',NULL),(49,'CrossFit Able Hanam','837_ Hanam-daero Hanam-si',NULL),(50,'CrossFit Gangnam','B1 Fl. 19-2_ Nonhyeon 1-dong Gangnam-gu',NULL);
/*!40000 ALTER TABLE `box` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_record`
--

DROP TABLE IF EXISTS `daily_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `wod_type_id` int DEFAULT NULL,
  `date` date DEFAULT (curdate()),
  `wod_description` varchar(1000) DEFAULT NULL,
  `memo` varchar(2000) DEFAULT NULL,
  `detail` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_daily_record_1` (`user_id`),
  KEY `FK_wod_type_TO_daily_record_1` (`wod_type_id`),
  CONSTRAINT `FK_user_TO_daily_record_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_wod_type_TO_daily_record_1` FOREIGN KEY (`wod_type_id`) REFERENCES `wod_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_record`
--

LOCK TABLES `daily_record` WRITE;
/*!40000 ALTER TABLE `daily_record` DISABLE KEYS */;
INSERT INTO `daily_record` VALUES (22,65,2,'2023-10-04',NULL,'dfssdfsd','asfff'),(23,65,3,'2023-10-02',NULL,'ddddddddd','ddddddd'),(24,65,1,'2023-10-10',NULL,'111','Clean'),(25,65,2,'2023-10-12',NULL,'cccccc','dddd'),(28,65,1,'2023-10-11',NULL,'sdsdsds','dsdsd'),(29,61,1,'2023-10-05',NULL,'hard','work'),(30,61,1,'2023-10-04',NULL,'ww','qq'),(31,65,1,'2023-10-24',NULL,'24444','24'),(32,65,1,'2023-10-05',NULL,'Buy In \n\n100 Box Jump Over\n\n​\n\n21Round\n\n5 HSPU\n\n3 Power Clean 155/105\n\n30 DU\n\n​\n\nCash Out\n\n100 Lateral Burpee','Team of 3');
/*!40000 ALTER TABLE `daily_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file` (
  `id` int NOT NULL AUTO_INCREMENT,
  `daily_record_id` int DEFAULT NULL,
  `file_path` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_daily_record_TO_file_1` (`daily_record_id`),
  CONSTRAINT `FK_daily_record_TO_file_1` FOREIGN KEY (`daily_record_id`) REFERENCES `daily_record` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `health_word`
--

DROP TABLE IF EXISTS `health_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `health_word` (
  `health_word_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `count` int DEFAULT NULL,
  PRIMARY KEY (`health_word_id`),
  UNIQUE KEY `name` (`name`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22014 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `health_word`
--

LOCK TABLES `health_word` WRITE;
/*!40000 ALTER TABLE `health_word` DISABLE KEYS */;
INSERT INTO `health_word` VALUES (21433,'가',3),(21434,'일정',1),(21435,'아웃도어',1),(21436,'전',2),(21437,'일반',2),(21438,'현관문',1),(21439,'직립',1),(21440,'마스터',1),(21441,'남편',1),(21442,'발견',2),(21443,'병원',3),(21444,'레',2),(21445,'북부',1),(21446,'조명',1),(21447,'핵심',1),(21448,'구간',1),(21449,'분석',2),(21450,'질병',6),(21451,'일간',1),(21452,'설사',1),(21453,'점',3),(21454,'서비스',3),(21455,'초점',1),(21456,'접근',1),(21457,'정부',1),(21458,'박',1),(21459,'전자',1),(21460,'밖',2),(21461,'발',2),(21462,'개',1),(21463,'주부',1),(21464,'해당',4),(21465,'균형',1),(21466,'환자',8),(21467,'모니터링',1),(21468,'상태',3),(21469,'밥',1),(21470,'현지',6),(21471,'차',1),(21472,'역발상',1),(21473,'시작',12),(21474,'협력',2),(21475,'정리',1),(21476,'배',3),(21477,'호흡',1),(21478,'지역',1),(21479,'자회사',1),(21480,'기록',1),(21481,'최근',2),(21482,'충격',5),(21483,'검사',1),(21484,'국민',1),(21485,'메가',2),(21486,'생애',1),(21487,'중독증',1),(21488,'진출',1),(21489,'제공',1),(21490,'학회',1),(21491,'트레',1),(21492,'입문',2),(21493,'코리아',1),(21494,'운동화',1),(21495,'리버',3),(21496,'연령',4),(21497,'지금',1),(21498,'시장',1),(21499,'위원',1),(21500,'차이',1),(21501,'발생',2),(21502,'내면',1),(21503,'혈압',1),(21504,'심리',1),(21505,'마디',2),(21506,'끝',3),(21507,'실시',2),(21508,'미국',2),(21509,'내용',1),(21510,'가족',1),(21511,'야외',1),(21512,'인공',2),(21513,'서브',1),(21514,'행태',2),(21515,'의료',3),(21516,'그룹사',1),(21517,'제프',1),(21518,'법칙',1),(21519,'사람',16),(21520,'페이스',3),(21521,'이하',2),(21522,'성인',1),(21523,'종',1),(21524,'공단',1),(21525,'게',8),(21526,'개선',2),(21527,'이해',1),(21528,'스트레스',7),(21529,'동안',6),(21530,'엘리트',1),(21531,'엄마',3),(21532,'공식',1),(21533,'날',1),(21534,'민주당',1),(21535,'정기',1),(21536,'뒤',1),(21537,'유기체',1),(21538,'남',1),(21539,'시점',2),(21540,'주기',1),(21541,'경험',6),(21542,'시간',15),(21543,'산',2),(21544,'근육',3),(21545,'게재',1),(21546,'관리',1),(21547,'정형',1),(21548,'고통',2),(21549,'미만',3),(21550,'다이어트',1),(21551,'기준',2),(21552,'탈',1),(21553,'강화',2),(21554,'무릎',3),(21555,'혼자',1),(21556,'뇌졸중',5),(21557,'호전',1),(21558,'도전',1),(21559,'불안',1),(21560,'발한',1),(21561,'연결',1),(21562,'출시',1),(21563,'실패',1),(21564,'여성',5),(21565,'일상',5),(21566,'기본',2),(21567,'구체',1),(21568,'선수',1),(21569,'일본',2),(21570,'중학교',2),(21571,'활동',19),(21572,'솔루션',1),(21573,'인구',2),(21574,'무리',4),(21575,'초등',1),(21576,'서울병원',1),(21577,'국내',1),(21578,'업그레이드',1),(21579,'곳',1),(21580,'피임법',1),(21581,'추적',1),(21582,'보',1),(21583,'체육',1),(21584,'추가',2),(21585,'공',1),(21586,'주',1),(21587,'지능',1),(21588,'다음',2),(21589,'허리',1),(21590,'현황',1),(21591,'여학교',1),(21592,'서울',2),(21593,'전날',1),(21594,'체지방',2),(21595,'생활',2),(21596,'여부',1),(21597,'사례',1),(21598,'양종',1),(21599,'중절',1),(21600,'명심',3),(21601,'지난해',3),(21602,'프로그램',1),(21603,'데이터',1),(21604,'압도',1),(21605,'제출',1),(21606,'의학',2),(21607,'산부인과',1),(21608,'예비',1),(21609,'유두',1),(21610,'논문',4),(21611,'어려움',1),(21612,'간격',2),(21613,'성',2),(21614,'한국인',1),(21615,'매슈',1),(21616,'연구진',6),(21617,'악영향',2),(21618,'검토',1),(21619,'노래',1),(21620,'사무실',1),(21621,'딸',5),(21622,'마스터스',1),(21623,'자가용',1),(21624,'일상생활',1),(21625,'최대',2),(21626,'마사이족',1),(21627,'부모',1),(21628,'요구',1),(21629,'땀',1),(21630,'정원',2),(21631,'아',2),(21632,'땅',2),(21633,'바닥',2),(21634,'보도',2),(21635,'교사',1),(21636,'대표',1),(21637,'반면',1),(21638,'때',15),(21639,'생명',1),(21640,'자식',1),(21641,'온라인',1),(21642,'준비',3),(21643,'앞',1),(21644,'요소',1),(21645,'부담',1),(21646,'혜정',1),(21647,'연구',7),(21648,'종류',1),(21649,'마비',3),(21650,'교육부',1),(21651,'치료',2),(21652,'보폭',1),(21653,'순간',4),(21654,'애니',4),(21655,'정신',3),(21656,'식사',1),(21657,'집중',1),(21658,'토대',1),(21659,'조절',2),(21660,'당국',1),(21661,'변화',1),(21662,'추산',1),(21663,'경우',3),(21664,'뒤꿈치',1),(21665,'벤지',1),(21666,'산책',1),(21667,'원칙',1),(21668,'웨이',2),(21669,'순차',1),(21670,'협약',1),(21671,'등록',1),(21672,'일부',1),(21673,'남성',1),(21674,'실제',2),(21675,'춤',2),(21676,'익명',1),(21677,'성별',2),(21678,'처음',6),(21679,'이용',1),(21680,'확률',1),(21681,'칠레',1),(21682,'대부분',1),(21683,'통계',1),(21684,'생식',1),(21685,'성인식',1),(21686,'노력',1),(21687,'캐서린',1),(21688,'조정',1),(21689,'청소년',12),(21690,'진단',1),(21691,'걸음',1),(21692,'제외',2),(21693,'케냐',3),(21694,'전문가',1),(21695,'필요',6),(21696,'신체',11),(21697,'카마',1),(21698,'개발원',1),(21699,'말',11),(21700,'시설',2),(21701,'피임',2),(21702,'대상',2),(21703,'호주',1),(21704,'분당',1),(21705,'뛰다',1),(21706,'기술',3),(21707,'탄수화물',2),(21708,'시스템',1),(21709,'혈당',1),(21710,'전국',1),(21711,'웹진',1),(21712,'설명',4),(21713,'광고',1),(21714,'지장',1),(21715,'하소연',2),(21716,'뉴시스',2),(21717,'데이',1),(21718,'이대',1),(21719,'보건',2),(21720,'마니',1),(21721,'업무',1),(21722,'중등',1),(21723,'출발',1),(21724,'증가',7),(21725,'발목',1),(21726,'순',1),(21727,'소비',1),(21728,'심장',6),(21729,'헬스',2),(21730,'단발',1),(21731,'마라토너',2),(21732,'조사',4),(21733,'성교육',3),(21734,'연구원',3),(21735,'숨',1),(21736,'시속',14),(21737,'평생',2),(21738,'휴식',3),(21739,'건강',17),(21740,'이유',1),(21741,'초등학교',2),(21742,'능력',4),(21743,'네이션',2),(21744,'주민등록',1),(21745,'잘못',2),(21746,'몸매',1),(21747,'추세',1),(21748,'세계보건기구',1),(21749,'약간',3),(21750,'인원',3),(21751,'상당',1),(21752,'엑스레이',1),(21753,'발달',1),(21754,'실내',1),(21755,'상담',3),(21756,'호소',1),(21757,'발가락',1),(21758,'단련',1),(21759,'정도',6),(21760,'지적',1),(21761,'결과',9),(21762,'강도',9),(21763,'혜택',1),(21764,'산보',1),(21765,'계획',1),(21766,'과도',1),(21767,'성관계',13),(21768,'의원',2),(21769,'청소',1),(21770,'아프리카',1),(21771,'추행',1),(21772,'파트너',1),(21773,'지방',3),(21774,'이콜',1),(21775,'중앙',1),(21776,'팔다리',1),(21777,'카',4),(21778,'대항',1),(21779,'심박수',1),(21780,'칼',3),(21781,'인식',1),(21782,'사진',1),(21783,'부정',1),(21784,'지표',1),(21785,'사막',3),(21786,'당황',1),(21787,'체계',1),(21788,'커뮤니티',1),(21789,'하루',5),(21790,'사지',1),(21791,'과정',1),(21792,'인대',1),(21793,'통증',1),(21794,'동물',7),(21795,'순서',1),(21796,'입문자',1),(21797,'바이러스',2),(21798,'스크린',1),(21799,'장거리',1),(21800,'하중',1),(21801,'본격',4),(21802,'아이',4),(21803,'사망',6),(21804,'공중',1),(21805,'목',2),(21806,'역대',1),(21807,'결합',1),(21808,'가능',1),(21809,'원인',3),(21810,'드밀',1),(21811,'유지',1),(21812,'몸',6),(21813,'학생',7),(21814,'우리나라',3),(21815,'후',3),(21816,'체중',5),(21817,'웅',2),(21818,'랜싯',1),(21819,'전화',5),(21820,'정책',1),(21821,'단계',1),(21822,'시기',1),(21823,'동작',1),(21824,'적용',1),(21825,'간호사',2),(21826,'브레이크',10),(21827,'사연',1),(21828,'참가자',1),(21829,'생각',2),(21830,'링크',1),(21831,'교수',2),(21832,'안팎',1),(21833,'과거',1),(21834,'예전',1),(21835,'포함',1),(21836,'튜브',1),(21837,'심장마비',5),(21838,'엑스',3),(21839,'병리',1),(21840,'운동복',1),(21841,'수영',1),(21842,'답',1),(21843,'의문',2),(21844,'남인수',1),(21845,'평소',2),(21846,'종합병원',2),(21847,'이동',1),(21848,'유산소',1),(21849,'주법',2),(21850,'괴질',1),(21851,'이점',3),(21852,'자사',1),(21853,'책임감',1),(21854,'이전',1),(21855,'뼈',2),(21856,'고민',1),(21857,'파',1),(21858,'나이로비',1),(21859,'학년',2),(21860,'합의하',1),(21861,'팔',1),(21862,'융통성',1),(21863,'예정',2),(21864,'분간',2),(21865,'반반',1),(21866,'모체',1),(21867,'반려',5),(21868,'관절',1),(21869,'유',1),(21870,'박사',2),(21871,'완주',5),(21872,'국민체육진흥공단',1),(21873,'고강',1),(21874,'관리청',1),(21875,'증세',1),(21876,'친숙',1),(21877,'장비',2),(21878,'중·고등',1),(21879,'거리',7),(21880,'계란',1),(21881,'남자친구',2),(21882,'평균',3),(21883,'감안',1),(21884,'집단',2),(21885,'카운티',3),(21886,'이제',4),(21887,'장기',1),(21888,'치명',1),(21889,'무',1),(21890,'체액',1),(21891,'워크',6),(21892,'예방',3),(21893,'자살',1),(21894,'여자',2),(21895,'초보자',7),(21896,'전신',1),(21897,'달리기',14),(21898,'장치',1),(21899,'위험',13),(21900,'손실',1),(21901,'효과',2),(21902,'활기',1),(21903,'고려',1),(21904,'수치',1),(21905,'학부',1),(21906,'주변',2),(21907,'다리',2),(21908,'중간중간',1),(21909,'콤',4),(21910,'사용',2),(21911,'정보',1),(21912,'적응',1),(21913,'감소',6),(21914,'도움',3),(21915,'우려',2),(21916,'성명',1),(21917,'나중',2),(21918,'전달',1),(21919,'보험',2),(21920,'이',3),(21921,'기자',2),(21922,'사회',2),(21923,'일',5),(21924,'얘기',1),(21925,'보급',1),(21926,'내막',1),(21927,'저자',1),(21928,'차트',1),(21929,'한국',2),(21930,'여가',1),(21931,'이번',2),(21932,'권장',1),(21933,'도시',1),(21934,'스리',1),(21935,'진료',7),(21936,'영국인',1),(21937,'영국',1),(21938,'인간',2),(21939,'개발',2),(21940,'우울증',9),(21941,'텔레콤',2),(21942,'페',1),(21943,'데일리',1),(21944,'대회',1),(21945,'비교',1),(21946,'해외',1),(21947,'본부',1),(21948,'사실',5),(21949,'움직임',2),(21950,'마라톤',15),(21951,'파악',1),(21952,'마찬가지',2),(21953,'양육',1),(21954,'추후',1),(21955,'최소',2),(21956,'스포츠',2),(21957,'자세',2),(21958,'지인이',1),(21959,'러브',1),(21960,'의미',2),(21961,'착용',1),(21962,'시드니',2),(21963,'단축',2),(21964,'산화',1),(21965,'운동',24),(21966,'고등학교',1),(21967,'기간',3),(21968,'부암',1),(21969,'방식',2),(21970,'임신',7),(21971,'운동량',1),(21972,'독',1),(21973,'과학',1),(21974,'반복',2),(21975,'작년',1),(21976,'집안일',1),(21977,'조깅',11),(21978,'별개',1),(21979,'속도',6),(21980,'부하',1),(21981,'폐',1),(21982,'관계',2),(21983,'보호',1),(21984,'지속',3),(21985,'웨어',1),(21986,'이상',10),(21987,'경고',1),(21988,'발표',1),(21989,'활용',1),(21990,'조기',6),(21991,'이내',1),(21992,'확인',1),(21993,'영향',1),(21994,'증진',1),(21995,'산모',1),(21996,'강박관념',1),(21997,'홀딩스',3),(21998,'아타',1),(21999,'규칙',3),(22000,'자궁',3),(22001,'희망',1),(22002,'러',2),(22003,'폐쇄',1),(22004,'태아',1),(22005,'문제',2),(22006,'입원',3),(22007,'통계청',1),(22008,'후기',1),(22009,'감염',6),(22010,'서부',2),(22011,'기반',1),(22012,'학술',1),(22013,'모양',1);
/*!40000 ALTER TABLE `health_word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_record`
--

DROP TABLE IF EXISTS `personal_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `workout_id` int DEFAULT NULL,
  `max_weight` int DEFAULT NULL,
  `create_date` date DEFAULT (curdate()),
  PRIMARY KEY (`id`),
  KEY `FK_user_TO_personal_record_1` (`user_id`),
  KEY `FK_workout_TO_personal_record_1` (`workout_id`),
  CONSTRAINT `FK_user_TO_personal_record_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_workout_TO_personal_record_1` FOREIGN KEY (`workout_id`) REFERENCES `workout` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_record`
--

LOCK TABLES `personal_record` WRITE;
/*!40000 ALTER TABLE `personal_record` DISABLE KEYS */;
INSERT INTO `personal_record` VALUES (38,65,48,25,'2023-08-09'),(39,65,48,35,'2023-09-04'),(40,65,48,65,'2023-02-21'),(41,65,48,12,'2023-07-15'),(42,65,48,11,'2023-04-10'),(43,65,48,50,'2023-10-04'),(44,65,48,15,'2023-03-09'),(45,65,94,123,'2023-10-04'),(46,65,89,100,'2023-10-04'),(47,65,54,11,'2023-10-04'),(48,65,108,100,'2023-10-04'),(49,65,137,123,'2023-10-04'),(50,65,135,111,'2023-10-04'),(51,65,78,102,'2023-10-04'),(52,65,200,30,'2023-10-04'),(55,65,48,121,'2023-08-20'),(56,65,26,20,'2023-10-04'),(57,65,191,13,'2023-10-04'),(58,65,51,20,'2023-10-04');
/*!40000 ALTER TABLE `personal_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_img`
--

DROP TABLE IF EXISTS `profile_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_img` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_name` varchar(1000) DEFAULT NULL,
  `file_path` varchar(1000) DEFAULT NULL,
  `original_file_name` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_img`
--

LOCK TABLES `profile_img` WRITE;
/*!40000 ALTER TABLE `profile_img` DISABLE KEYS */;
INSERT INTO `profile_img` VALUES (1,'737d137b-e634-483d-a8ad-e1eb482d8c27.jpeg','/app/file/profileImg/737d137b-e634-483d-a8ad-e1eb482d8c27.jpeg','기본프사.jpeg'),(96,'b9dc35d0-3196-4859-b1ce-1f6bfaa86934.jpg','/app/file/profileImg/b9dc35d0-3196-4859-b1ce-1f6bfaa86934.jpg','111462746.2.jpg');
/*!40000 ALTER TABLE `profile_img` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sports_word`
--

DROP TABLE IF EXISTS `sports_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sports_word` (
  `sports_word_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `count` int DEFAULT NULL,
  PRIMARY KEY (`sports_word_id`),
  UNIQUE KEY `name` (`name`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sports_word`
--

LOCK TABLES `sports_word` WRITE;
/*!40000 ALTER TABLE `sports_word` DISABLE KEYS */;
INSERT INTO `sports_word` VALUES (1,'골프',4),(2,'근대5종',0),(3,'농구',20),(4,'다이빙',28),(5,'럭비',0),(6,'레슬링',11),(7,'배구',31),(8,'배드민턴',10),(9,'복싱',5),(10,'브레이킹',0),(11,'비치발리볼',0),(12,'사격',0),(13,'사이클',7),(14,'서핑',0),(15,'수구',0),(16,'수영',11),(17,'승마',0),(18,'스케이트보드',0),(19,'스포츠클라이밍',0),(20,'아티스틱스위밍',0),(21,'역도',9),(22,'양궁',82),(23,'요트',0),(24,'유도',3),(25,'육상',26),(26,'조정',0),(27,'체조',0),(28,'축구',36),(29,'카누',0),(30,'탁구',5),(31,'태권도',0),(32,'테니스',10),(33,'트라이애슬론',0),(34,'펜싱',1),(35,'하키',1),(36,'핸드볼',4),(37,'가라테',0),(38,'라크로스',0),(39,'라켓',0),(40,'로크',0),(41,'모터보트',0),(42,'소프트볼',2),(43,'야구',9),(44,'주드폼',0),(45,'줄다리기',0),(46,'크로케',0),(47,'크리켓',0),(48,'폴로',2),(49,'펠로타',0),(50,'글라이딩',0),(51,'글리마',0),(52,'라칸',0),(53,'롤러하키',0),(54,'무도',0),(55,'미식축구',0),(56,'볼링',1),(57,'사바트',0),(58,'오지풋볼',0),(59,'수상스키',0),(60,'코프볼',0),(61,'페세팔로',0),(62,'노르딕복합',0),(63,'루지',0),(64,'바이애슬론',0),(65,'봅슬레이',0),(66,'쇼트트랙',0),(67,'스노보드',0),(68,'스켈레톤',0),(69,'스키점프',0),(70,'스피드스케이팅',0),(71,'아이스하키',0),(72,'알파인스키',0),(73,'컬링',0),(74,'크로스컨트리',0),(75,'프리스타일스키',0),(76,'피겨스케이팅',0),(77,'밀리터리패트롤',0),(78,'개썰매',0),(79,'밴디',0),(80,'스키저링',0),(81,'스피드스키',0),(82,'아이스스톡',0),(83,'노르딕스키',0),(84,'필드하키',0),(85,'택견',0),(86,'쿵푸',0),(87,'씨름',0),(88,'킥복싱',0),(89,'팔씨름',0),(90,'주짓수',0),(91,'링',1),(92,'철봉',0),(93,'도마',0),(94,'평균대',0),(95,'마루운동',0),(96,'싱크로나이즈',0),(97,'라켓볼',0),(98,'리얼테니스',0),(99,'스쿼시',0),(100,'정구',0),(101,'킨볼',0),(102,'피구',0),(103,'게이트볼',0),(104,'족구',0),(105,'티볼',0),(106,'세팍타크로',0),(107,'보치아',0),(108,'당구',0),(109,'마라톤',0),(110,'멀리뛰기',0),(111,'높이뛰기',93),(112,'장대높이뛰기',0),(113,'창던지기',0),(114,'원반던지기',0),(115,'포환던지기',0),(116,'장애물달리기',0),(117,'크로스핏',0),(118,'UFC',0),(119,'MMA',0),(120,'요가',0),(121,'헬스',0),(122,'발레',0);
/*!40000 ALTER TABLE `sports_word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `box_id` int DEFAULT '1',
  `profile_id` int DEFAULT '1',
  `email` varchar(100) DEFAULT NULL,
  `refresh_token` varchar(1000) DEFAULT NULL,
  `nickname` varchar(20) DEFAULT NULL,
  `age_range` varchar(30) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT '1',
  `birthday` date DEFAULT NULL,
  `is_trainer` tinyint(1) DEFAULT NULL,
  `regist_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `role` varchar(45) DEFAULT 'GUEST',
  `social_id` varchar(45) DEFAULT NULL,
  `social_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_crossfit_box_TO_user_1` (`box_id`),
  KEY `FK_profile_img_TO_user_1` (`profile_id`),
  CONSTRAINT `FK_crossfit_box_TO_user_1` FOREIGN KEY (`box_id`) REFERENCES `box` (`id`),
  CONSTRAINT `FK_profile_img_TO_user_1` FOREIGN KEY (`profile_id`) REFERENCES `profile_img` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (61,1,96,'choiyc1446@gmail.com','Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE2OTc2ODAyODd9.nrbABGJS28ISw7LV0uG2GE_SlaKJYX1ocpo1MbLicIosW1bx0PmhB6WP7uV6EkudvVSotD_PWvN6HvL0N3XccQ','최영창','20대',1,NULL,NULL,'2023-09-27 05:05:10','USER','3039143679','KAKAO'),(65,2,1,'aaa@aaa.com','Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE2OTc2NzQ0Njd9.tHx4EBhTGyVgqB5lc_8cMJ1v6AeTyOwijNQfmCt-OBfSVXa7I0Y87kvIWfWXBG7kntM6lomKLYDvlLgkvkcX9g','꽃개','20대',0,NULL,NULL,'2023-09-27 06:01:19','USER','3027712151','KAKAO');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wod`
--

DROP TABLE IF EXISTS `wod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wod` (
  `id` int NOT NULL AUTO_INCREMENT,
  `wod_type_id` int DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `is_named` tinyint(1) DEFAULT NULL,
  `rep` varchar(50) DEFAULT NULL,
  `round` int DEFAULT NULL,
  `time_cap` time DEFAULT NULL,
  `wod_category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_wod_type_TO_wod_1` (`wod_type_id`),
  KEY `FK_wod_category_TO_wod_1` (`wod_category_id`),
  CONSTRAINT `FK_wod_category_TO_wod_1` FOREIGN KEY (`wod_category_id`) REFERENCES `wod_category` (`id`),
  CONSTRAINT `FK_wod_type_TO_wod_1` FOREIGN KEY (`wod_type_id`) REFERENCES `wod_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wod`
--

LOCK TABLES `wod` WRITE;
/*!40000 ALTER TABLE `wod` DISABLE KEYS */;
INSERT INTO `wod` VALUES (1,1,'Murph',1,'0',1,'00:00:01',2);
/*!40000 ALTER TABLE `wod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wod_category`
--

DROP TABLE IF EXISTS `wod_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wod_category` (
  `id` int NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wod_category`
--

LOCK TABLES `wod_category` WRITE;
/*!40000 ALTER TABLE `wod_category` DISABLE KEYS */;
INSERT INTO `wod_category` VALUES (1,'Girls'),(2,'Hero');
/*!40000 ALTER TABLE `wod_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wod_record`
--

DROP TABLE IF EXISTS `wod_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wod_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `wod_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `time` time DEFAULT NULL,
  `count` int DEFAULT NULL,
  `create_date` date DEFAULT (curdate()),
  PRIMARY KEY (`id`),
  KEY `FK_wod_TO_wod_record_1` (`wod_id`),
  KEY `FK_user_TO_wod_record_1` (`user_id`),
  CONSTRAINT `FK_user_TO_wod_record_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_wod_TO_wod_record_1` FOREIGN KEY (`wod_id`) REFERENCES `wod` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wod_record`
--

LOCK TABLES `wod_record` WRITE;
/*!40000 ALTER TABLE `wod_record` DISABLE KEYS */;
INSERT INTO `wod_record` VALUES (21,1,61,'00:00:00',25,'2023-09-27'),(23,1,65,'00:17:45',33,'2023-10-01'),(25,1,65,'00:32:11',0,'2023-10-04'),(26,1,65,'00:13:45',0,'2023-10-04');
/*!40000 ALTER TABLE `wod_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wod_type`
--

DROP TABLE IF EXISTS `wod_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wod_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wod_type`
--

LOCK TABLES `wod_type` WRITE;
/*!40000 ALTER TABLE `wod_type` DISABLE KEYS */;
INSERT INTO `wod_type` VALUES (1,'For Time'),(2,'EMOM'),(3,'AMRAP'),(4,'Custom');
/*!40000 ALTER TABLE `wod_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wod_workout`
--

DROP TABLE IF EXISTS `wod_workout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wod_workout` (
  `id` int NOT NULL AUTO_INCREMENT,
  `wod_id` int DEFAULT NULL,
  `workout_id` int DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `count` int DEFAULT NULL,
  `distance` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_wod_TO_wod_workout_1` (`wod_id`),
  KEY `FK_workout_TO_wod_workout_1` (`workout_id`),
  CONSTRAINT `FK_wod_TO_wod_workout_1` FOREIGN KEY (`wod_id`) REFERENCES `wod` (`id`),
  CONSTRAINT `FK_workout_TO_wod_workout_1` FOREIGN KEY (`workout_id`) REFERENCES `workout` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wod_workout`
--

LOCK TABLES `wod_workout` WRITE;
/*!40000 ALTER TABLE `wod_workout` DISABLE KEYS */;
INSERT INTO `wod_workout` VALUES (1,1,184,0,0,1),(2,1,162,0,100,0),(3,1,166,0,200,0),(4,1,8,0,300,0),(5,1,184,0,0,1);
/*!40000 ALTER TABLE `wod_workout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word_count`
--

DROP TABLE IF EXISTS `word_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word_count` (
  `id` int NOT NULL AUTO_INCREMENT,
  `word` varchar(100) DEFAULT NULL,
  `count` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word_count`
--

LOCK TABLES `word_count` WRITE;
/*!40000 ALTER TABLE `word_count` DISABLE KEYS */;
/*!40000 ALTER TABLE `word_count` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workout`
--

DROP TABLE IF EXISTS `workout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workout` (
  `id` int NOT NULL AUTO_INCREMENT,
  `workout_type_id` int DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `ref_video` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_workout_type_TO_workout_1` (`workout_type_id`),
  CONSTRAINT `FK_workout_type_TO_workout_1` FOREIGN KEY (`workout_type_id`) REFERENCES `workout_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workout`
--

LOCK TABLES `workout` WRITE;
/*!40000 ALTER TABLE `workout` DISABLE KEYS */;
INSERT INTO `workout` VALUES (8,25,'Air Squat','','https://www.youtube.com/embed/C_VtOYc6j5c'),(9,24,'Alternating dumbbell snatches','','https://www.youtube.com/embed/KP7A3cFazOc'),(10,17,'Alternating floor press','','https://www.youtube.com/embed/DJwNDf0XDys'),(11,17,'Alternating Kettlebell Shoulder Press','','https://www.youtube.com/embed/kFekFUBDYfQ'),(12,24,'Alternating Kettlebell Snatch','','https://www.youtube.com/embed/nURJWJXywqg'),(13,3,'Assault Air Bike','','https://www.youtube.com/embed/YSrkGWpYnpo'),(14,27,'Atlas Stone Carry','','https://www.youtube.com/embed/ImZ9fR3wRus'),(15,27,'Atlas Stone Ground to Shoulder','','https://www.youtube.com/embed/857bGNXArZI'),(16,14,'Atlas Stone Lunges','',''),(17,27,'Atlas Stone Over','','https://www.youtube.com/embed/RYlO3IeUkJ0'),(18,31,'Axel Thruster','','https://www.youtube.com/embed/Dm2h4_I1b0U'),(19,8,'Axle Deadlift','','https://www.youtube.com/embed/FYeLBXRKYFs'),(20,10,'Back Extension GHD','','https://www.youtube.com/embed/xMyFXMZ6Ch0'),(21,10,'Back Extensions','','https://www.youtube.com/embed/xMyFXMZ6Ch0'),(22,13,'Back Flip','','https://www.youtube.com/embed/KnbrVE7WOrI'),(23,25,'Back Squat','','https://www.youtube.com/embed/ultWZbUMPL8'),(24,23,'Backward Run','','https://www.youtube.com/embed/PU6qPvT6sAc'),(25,30,'Ball Slams','','https://www.youtube.com/embed/qfKAbFV8250'),(26,2,'Barbell Sit-Up','','https://www.youtube.com/embed/BNMZj-qnQko'),(27,9,'Bar Dip','','https://www.youtube.com/embed/eERwCQHZqfA'),(28,15,'Bar Muscle-Up','','https://www.youtube.com/embed/Q5iONDBF7zY'),(29,16,'Battling Rope','','https://www.youtube.com/embed/sHl1HWEgtrs'),(30,16,'Bear Crawl','','https://www.youtube.com/embed/t8XLor7unqU'),(31,17,'Bench press','','https://www.youtube.com/embed/XSza8hVTlmM'),(32,8,'Bent Barbell Row','','https://www.youtube.com/embed/4xq3BsKTzYo'),(33,3,'Bicycling','','https://www.youtube.com/embed/7Nt52CMsBoI'),(34,18,'Body row','','https://www.youtube.com/embed/jUNXKJTkSwg'),(35,13,'Box Jump','','https://www.youtube.com/embed/52r_Ul5k03g'),(36,13,'Box Jump Overs','','https://www.youtube.com/embed/g9NVRxtFqAM'),(37,14,'Box Step Ups','','https://www.youtube.com/embed/dw8xOAr6RuM'),(38,23,'Buddy Carry','','https://www.youtube.com/embed/AdkwEk-HnmM'),(39,4,'Burpee','','https://www.youtube.com/embed/TU8QYVW0gDU'),(40,4,'Burpee Bar-Facing','','https://www.youtube.com/embed/jnOLN__0paE'),(41,4,'Burpee Bar Muscle-up','','https://www.youtube.com/embed/iAUzkrTsCDk'),(42,4,'Burpee Box Jump Overs','','https://www.youtube.com/embed/_1N9l9qsNRs'),(43,4,'Burpee Muscle-Up','',''),(44,4,'Burpee Pull-Up','','https://www.youtube.com/embed/jVzrLDIRqnE'),(45,18,'Chest-To-Bar Pull-Up','','https://www.youtube.com/embed/p9Stan68FYM'),(46,18,'Chin-Up','','https://www.youtube.com/embed/_71FpEaq-fQ'),(47,20,'Clapping Push-Up','','https://www.youtube.com/embed/EYwWCgM198U'),(48,5,'Clean','','https://www.youtube.com/embed/EKRiW9Yt3Ps'),(49,5,'Clean and Jerk','','https://www.youtube.com/embed/rwMorlCDtis'),(50,8,'Clean Extension','','https://www.youtube.com/embed/YmvIKsnARPM'),(51,8,'Clean Pull','','https://www.youtube.com/embed/3iWRZhJthqI'),(52,5,'Clean To Overhead Press','','https://www.youtube.com/embed/pajZn-M-r4Q'),(53,31,'Cluster','','https://www.youtube.com/embed/plCzO45g9nc'),(54,2,'Crunch','','https://www.youtube.com/embed/Xyd_fa5zoEU'),(55,5,'Curtis Ps','','https://www.youtube.com/embed/yQf3Wy1F4rc'),(56,8,'Deadlift','','https://www.youtube.com/embed/op9kVnSso6Q'),(57,20,'Deficit Handstand Push-Ups','','https://www.youtube.com/embed/7n1ZFu-mFdI'),(58,26,'Dip Bar L-Sit','','https://www.youtube.com/embed/q4hdSdt8fHk'),(59,16,'Donkey Kicks','','https://www.youtube.com/embed/SJ1Xuz9D-ZQ'),(60,5,'Double Kettlebell Clean','','https://www.youtube.com/embed/PSqr8UKSOjw'),(61,8,'Double Kettlebell Deadlift','','https://www.youtube.com/embed/zFT_JnU9mLE'),(62,24,'Double Kettlebell Snatch','','https://www.youtube.com/embed/-9lMCou9XF8'),(63,31,'Double Kettlebells Thrusters','','https://www.youtube.com/embed/gpB9AsEZLM4'),(64,29,'Double Kettlebell Swing','','https://www.youtube.com/embed/Tr4yzNiqOWY'),(65,12,'Double Unders Jump Rope','','https://www.youtube.com/embed/-tF3hUsPZAI'),(66,16,'Double Whip Smash Battling Ropes','','https://www.youtube.com/embed/iL8qiQArVGc'),(67,14,'Dumbbell box step-ups','','https://www.youtube.com/embed/37tVohr7LcE'),(68,4,'Dumbbell Burpee Deadlifts','','https://www.youtube.com/embed/vFPjke5AS9c'),(69,5,'Dumbbell Clean','','https://www.youtube.com/embed/SYxObzJ3gn0'),(70,8,'Dumbbell Deadlifts','','https://www.youtube.com/embed/YzsVO8YuQUI'),(71,5,'Dumbbell Hang Clean and Jerks','','https://www.youtube.com/embed/r6fZ1eRFg30'),(72,24,'Dumbbell Hang Split Snatch','','https://www.youtube.com/embed/C28PXuGenbY'),(73,5,'Dumbbell Hang Squat Clean','','https://www.youtube.com/embed/CUaxieWW0tw'),(74,14,'Dumbbell Lunge','','https://www.youtube.com/embed/YJ3RxtkL5SA'),(75,5,'Dumbbell Power Clean','','https://www.youtube.com/embed/vh0Tj7G4k0c'),(76,24,'Dumbbell Power Snatch','','https://www.youtube.com/embed/3mlhF3dptAo'),(77,17,'Dumbbell Press','','https://www.youtube.com/embed/AqzDJHxynwo'),(78,11,'Dumbbell Push Jerk','','https://www.youtube.com/embed/QhvxG1YWe_o'),(79,17,'Dumbbell Push Press','','https://www.youtube.com/embed/MqvN10OF5fo'),(80,24,'Dumbbell Snatch','','https://www.youtube.com/embed/R0mhHuVrLHA'),(81,5,'Dumbbell Split Clean','','https://www.youtube.com/embed/52Xai_rYsQI'),(82,5,'Dumbbell Squat Clean','','https://www.youtube.com/embed/CUaxieWW0tw'),(83,25,'Dumbbell squats','','https://www.youtube.com/embed/JwaGTOxUSeg'),(84,24,'Dumbbell Squat Snatch','','https://www.youtube.com/embed/NyoBUxleQDw'),(85,31,'Dumbbell Thruster','','https://www.youtube.com/embed/M5gEwLTtWbg'),(86,32,'Dumbbell Waiters Walk','','https://www.youtube.com/embed/6iD-O2_KL5c'),(87,32,'Farmers walk','','https://www.youtube.com/embed/s56hEjKFC08'),(88,17,'Floor Press','','https://www.youtube.com/embed/-LaY2tDZlfA'),(89,2,'Floor Wipers','','https://www.youtube.com/embed/YB1XDXkx0zk'),(90,16,'Forward Roll','','https://www.youtube.com/embed/R0-xTcLg_ao'),(91,20,'Freestanding Handstand Push-Up','','https://www.youtube.com/embed/tQhrk6WMcKw'),(92,14,'Front Rack Lunge','','https://www.youtube.com/embed/f3WLs_HutLw'),(93,25,'Front Squat','','https://www.youtube.com/embed/m4ytaCJZpl0'),(94,2,'GHD Sit-up','','https://www.youtube.com/embed/1pbZ8mX2D1U'),(95,25,'Goblet Squat','','https://www.youtube.com/embed/MeIiIdhvXT4'),(96,20,'Hand Release Push-Up','','https://www.youtube.com/embed/hfaUWLlhvKk'),(97,16,'Handstand','','https://www.youtube.com/embed/T2G4O8R-SFg'),(98,20,'Handstand Push-up','','https://www.youtube.com/embed/hvoQiF0kBI8'),(99,20,'Handstand Ring Push-Up','','https://www.youtube.com/embed/VYSQf6JhLro'),(100,32,'Handstand Walk','','https://www.youtube.com/embed/I5p2VVDupq8'),(101,5,'Hang Clean','','https://www.youtube.com/embed/eVWbmwSg5CE'),(102,16,'Hanging Hip Touches','','https://www.youtube.com/embed/SJ3WqnnyvcQ'),(103,5,'Hang Power Clean','','https://www.youtube.com/embed/_iUFG1-H7d0'),(104,24,'Hang Power Snatch','','https://www.youtube.com/embed/8AyTzORaBM8'),(105,24,'Hang Snatch','','https://www.youtube.com/embed/oTlSsPZaewg'),(106,5,'Hang Squat Clean','','https://www.youtube.com/embed/YZUdVyVV3uI'),(107,24,'Hang Squat Snatch','','https://www.youtube.com/embed/pGwJoZ6twgM'),(108,2,'Hollow Rock','','https://www.youtube.com/embed/p7j02V1fIzU'),(109,4,'Inverted Burpee','','https://www.youtube.com/embed/mHjude_kmDE'),(110,11,'Jerk','','https://www.youtube.com/embed/V-hKuAfWNUw'),(111,13,'Jumping Chest To Bar Pull-Up','','https://www.youtube.com/embed/YdW5TJQdfyY'),(112,13,'Jumping Jack','','https://www.youtube.com/embed/c4DAnQ6DtF8'),(113,14,'Jumping Lunge','','https://www.youtube.com/embed/1ExU8445rbU'),(114,13,'Jumping Pull-up','','https://www.youtube.com/embed/HbUa7Q0PUTA'),(115,12,'Jump Rope Single','','https://www.youtube.com/embed/hCuXYrTOMxI'),(116,5,'Kettlebell Clean and Jerk','','https://www.youtube.com/embed/DGql83eyHRE'),(117,31,'Kettlebell Goblet Thruster','','https://www.youtube.com/embed/gI2fYF7ZAHI'),(118,16,'Kettlebell Halo','','https://www.youtube.com/embed/Zy6bgAxPeks'),(119,29,'Kettlebell High Pull','','https://www.youtube.com/embed/118S81wuJVg'),(120,11,'Kettlebell Push Jerk','','https://www.youtube.com/embed/bQuSGlC_euo'),(121,24,'Kettlebell Snatch','','https://www.youtube.com/embed/ZQccQg4kDf8'),(122,8,'Kettlebell Sumo Deadlift','','https://www.youtube.com/embed/sGNMEtZCkRY'),(123,8,'Kettlebell Sumo Deadlift High Pull','','https://www.youtube.com/embed/V0qNjLHV3_c'),(124,29,'Kettlebell Swing','','https://www.youtube.com/embed/vdezTMulJ-k'),(125,15,'Kipping Bar Muscle-Up','','https://www.youtube.com/embed/OCg3UXgzftc'),(126,18,'Kipping Chest-To-Bar Pull-Up','','https://www.youtube.com/embed/p9Stan68FYM'),(127,20,'Kipping Hanstand Push-Up','','https://www.youtube.com/embed/InRvHNUOlSs'),(128,18,'Kipping Pull-Up','','https://www.youtube.com/embed/r45xLlH7r_M'),(129,7,'Knees to Elbows','','https://www.youtube.com/embed/IJZpz5C1dAA'),(130,4,'Lateral Burpees','','https://www.youtube.com/embed/MBThz19Jpd0'),(131,13,'Lateral hops','','https://www.youtube.com/embed/bqbZqxqs8tY'),(132,13,'Lateral jump over barbell','','https://www.youtube.com/embed/WmGXrrb-wqc'),(133,24,'Left Arm Dumbbell Snatch','','https://www.youtube.com/embed/R0mhHuVrLHA&feature=youtu.be'),(134,14,'Left-arm Overhead Walking Lunges','','https://www.youtube.com/embed/uNMLS5f1sjM'),(135,2,'Leg Raises','','https://www.youtube.com/embed/JB2oyawG9KI'),(136,27,'Log Clean Press','','https://www.youtube.com/embed/KN7HOOJuwb4'),(137,2,'L-Sit Pull-Up','','https://www.youtube.com/embed/hHdD5Ksdnmk'),(138,6,'L-Sit Rope Climb','','https://www.youtube.com/embed/xcX8U1yjbYE'),(139,4,'Man Maker','','https://www.youtube.com/embed/2-6EPLtSLwU'),(140,5,'Medicine-Ball Clean','','https://www.youtube.com/embed/-nk0GqeSTJs'),(141,23,'Mountain Climber','','https://www.youtube.com/embed/DyeZM-_VnRc'),(142,5,'Muscle Clean','','https://www.youtube.com/embed/K7CctePUCYA'),(143,24,'Muscle Snatch','','https://www.youtube.com/embed/LRcTB2-Xyg8'),(144,15,'Muscle-up Strict','','https://www.youtube.com/embed/rtF51pQB6Wc'),(145,17,'One arm Kettlebell Press','','https://www.youtube.com/embed/jKBMDGRPWH4'),(146,22,'One Arm Kettlebell Row','','https://www.youtube.com/embed/2oUGxv-hO-A'),(147,31,'One Arm Kettlebell Thruster','','https://www.youtube.com/embed/OXGl9Etsg3M'),(148,25,'One Leg Squat','','https://www.youtube.com/embed/b4q0kqmF608'),(149,14,'Overhead Lunge','','https://www.youtube.com/embed/m6MczOv_Ayg'),(150,25,'Overhead Squat','','https://www.youtube.com/embed/RD_vUnqwqqI'),(151,32,'Overhead Walk','','https://www.youtube.com/embed/jcRKokkaN3o'),(152,28,'Paddle','','https://www.youtube.com/embed/bZ3BtyFLaDs'),(153,20,'Parallette Handstand push-up','','https://www.youtube.com/embed/gGKq91w8CQA'),(154,6,'Pegboard Ascents','',''),(155,25,'Pistol Squat','','https://www.youtube.com/embed/qDcniqddTeE'),(156,26,'Plank','','https://www.youtube.com/embed/MHQmRINu4jU'),(157,5,'Power Clean','','https://www.youtube.com/embed/GVt4uQ0sDJE'),(158,11,'Power Clean and Jerk','','https://www.youtube.com/embed/c-TD6-GESQk'),(159,24,'Power Snatch','','https://www.youtube.com/embed/tuOiNeTvLJs'),(160,17,'Pressing Snatch Balance','','https://www.youtube.com/embed/RxjY4CggkVA'),(161,27,'Prowler push','','https://www.youtube.com/embed/18CbSRB1NWg'),(162,18,'Pull-Up','','https://www.youtube.com/embed/r45xLlH7r_M'),(163,11,'Push Jerk','','https://www.youtube.com/embed/V-hKuAfWNUw'),(164,11,'Push Jerk Behind the Head','','https://www.youtube.com/embed/Pi9CNrORle8'),(165,17,'Push Press','','https://www.youtube.com/embed/X6-DMh-t4nQ'),(166,20,'Push-Ups','','https://www.youtube.com/embed/_l3ySVKYVJ8'),(167,8,'Rack Pulls','','https://www.youtube.com/embed/FF1745KfGCs'),(168,18,'Renegade Row','','https://www.youtube.com/embed/PJpTBj4ilZw'),(169,32,'Rescue Randy Drag','',''),(170,21,'Rest','','https://www.youtube.com/embed/38Cja_5_qYQ'),(171,24,'Right Arm Dumbbell Snatch','','https://www.youtube.com/embed/R0mhHuVrLHA&feature=youtu.be'),(172,14,'Right-arm Overhead Walking Lunges','',''),(173,20,'Ring Chest Fly','','https://www.youtube.com/embed/n4aEsVrtD4c'),(174,9,'Ring Dip','','https://www.youtube.com/embed/Vt0lO4jpIDo'),(175,20,'Ring Hand Stand Push Up','','https://www.youtube.com/embed/_38i--l_2Is'),(176,26,'Ring L-Sit','','https://www.youtube.com/embed/DemH-mw1O9I'),(177,15,'Ring Muscle-up','','https://www.youtube.com/embed/BQS4Kw7q7OQ'),(178,18,'Ring Pull Ups','','https://www.youtube.com/embed/59Kpdw7cqgY'),(179,20,'Ring Push-up','','https://www.youtube.com/embed/FRiiZRhapeU'),(180,18,'Ring Row','','https://www.youtube.com/embed/xhlReCpAE9k'),(181,6,'Rope Climb','','https://www.youtube.com/embed/qFE7pgOrj5w'),(182,6,'Rope Climb Legless','','https://www.youtube.com/embed/rfr-Tw3Pxh8'),(183,22,'Row','','https://www.youtube.com/embed/S7HEm-fd534'),(184,23,'Run','','https://www.youtube.com/embed/t7ZD68RKTT8'),(185,23,'Sandbag Carry','','https://www.youtube.com/embed/x9T87eB9Oh8'),(186,17,'Shoulder Press','','https://www.youtube.com/embed/xe19t2_6yis'),(187,11,'Shoulder to Overhead-FS2OH','','https://www.youtube.com/embed/jnK-G7_yIck'),(188,23,'Shuttle Sprint','','https://www.youtube.com/embed/Hr3ATDoMY8w'),(189,14,'Single-arm Dumbbell Overhead Lunge','','https://www.youtube.com/embed/J3DxelcaaMU'),(190,25,'Single-arm Dumbbell Overhead Squat','','https://www.youtube.com/embed/fa_yJa2XwXk'),(191,2,'Sit-Up','','https://www.youtube.com/embed/_HDZODOx7Zw'),(192,2,'Sit-up abmat','','https://www.youtube.com/embed/_HDZODOx7Zw'),(193,16,'SkiErg','',''),(194,32,'Sled Drag','','https://www.youtube.com/embed/NnXtHxnPKDU'),(195,16,'Sledge Hammer Strike','','https://www.youtube.com/embed/-QqTgBcjhEk'),(196,19,'Sled Push','','https://www.youtube.com/embed/AeOTolYwLeI'),(197,24,'Snatch','','https://www.youtube.com/embed/9xQp2sldyts'),(198,24,'Snatch Balance','','https://www.youtube.com/embed/XuFaD1sAVGI'),(199,8,'Snatch Pull','','https://www.youtube.com/embed/cRR87TYYGkE'),(200,11,'Split Jerk','','https://www.youtube.com/embed/PsiO8lZTU2I'),(201,25,'Split Squat','','https://www.youtube.com/embed/AMfbdugbcL8'),(202,23,'Sprint','','https://www.youtube.com/embed/_VX2gbN8pik'),(203,5,'Squat Clean','','https://www.youtube.com/embed/yTNZ9PQKWEw'),(204,11,'Squat Jerk','','https://www.youtube.com/embed/p88wsnJfRz8'),(205,13,'Squat Jumps','','https://www.youtube.com/embed/CVaEhXotL7M'),(206,24,'Squat Snatch','','https://www.youtube.com/embed/3Aia8mAHWLE'),(207,13,'Standing Broad Jump','','https://www.youtube.com/embed/HGKIFTL-TbE'),(208,13,'Star jump','','https://www.youtube.com/embed/hPFtd4K-khA'),(209,8,'Stiff-Legged Deadlift','','https://www.youtube.com/embed/1uDiW5--rAE'),(210,20,'Strict Handstand Push-up','','https://www.youtube.com/embed/hvoQiF0kBI8'),(211,18,'Strict Pull-Up','','https://www.youtube.com/embed/aAggnpPyR6E'),(212,9,'Strict Ring Dip','','https://www.youtube.com/embed/WeMoWDPs2YA'),(213,8,'Sumo Deadlift','','https://www.youtube.com/embed/wQHSYDSgDn8'),(214,8,'Sumo Deadlift High Pull','','https://www.youtube.com/embed/o6QniJ9FaGA'),(215,28,'Swim','','https://www.youtube.com/embed/vxYKF7DAU-w'),(216,31,'Thruster','','https://www.youtube.com/embed/aea5BGj9a8Y'),(217,27,'Tire Flip','','https://www.youtube.com/embed/wFbPbhNXEAg'),(218,16,'Tire Pull','','https://www.youtube.com/embed/eP3kazz_vl0'),(219,30,'Tire Throw','','https://www.youtube.com/embed/YQo85wPPUhw'),(220,2,'Toes-to-bar','','https://www.youtube.com/embed/_03pCKOv4l4'),(221,7,'Toes-to-rings','','https://www.youtube.com/embed/yAHl-4aBr0I'),(222,18,'Towel Pull-up','','https://www.youtube.com/embed/wTHOn3epZOI'),(223,12,'Triple-Unders','','https://www.youtube.com/embed/OSMvoZnh_ng'),(224,19,'Truck Push','','https://www.youtube.com/embed/KG2UgVmUldA'),(225,13,'Tuck jump','','https://www.youtube.com/embed/zh1v8jINBZ0'),(226,16,'Tumbler Pull','',''),(227,16,'Turkish Get-Up','','https://www.youtube.com/embed/-_zTytmHM94'),(228,22,'Two Arm KettleBell Row','','https://www.youtube.com/embed/Ka5fCG6Q_jw'),(229,2,'V Ups','','https://www.youtube.com/embed/Mk4zCq9b6hU'),(230,14,'Walking Lunge','','https://www.youtube.com/embed/L8fvypPrzzs'),(231,30,'Wall Ball','','https://www.youtube.com/embed/fpUD0mcFp_0'),(232,32,'Wall Climb','','https://www.youtube.com/embed/2TnX8j29tRY'),(233,9,'Weighted Bar Dips','',''),(234,14,'Weighted Lunges','','https://www.youtube.com/embed/ZPoMxOrIeO4'),(235,18,'Weighted Pull-up','','https://www.youtube.com/embed/lLMWO67K_lo'),(236,23,'Weighted run','','https://www.youtube.com/embed/o7E5hNVuraE'),(237,2,'Weighted Sit-Up','','https://www.youtube.com/embed/vlMbsyQGSD4'),(238,16,'XPO Trainer Sled Drag','','https://www.youtube.com/embed/Vb3LSut2K1w'),(239,19,'XPO Trainer Sled Push','','https://www.youtube.com/embed/QeNFCAYtwl8'),(240,27,'Yoke Carry','','https://www.youtube.com/embed/5IUFJVlZHmg');
/*!40000 ALTER TABLE `workout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workout_type`
--

DROP TABLE IF EXISTS `workout_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workout_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workout_type`
--

LOCK TABLES `workout_type` WRITE;
/*!40000 ALTER TABLE `workout_type` DISABLE KEYS */;
INSERT INTO `workout_type` VALUES (1,'None'),(2,'Abdominal'),(3,'Bike'),(4,'Burpees'),(5,'Cleans'),(6,'Climb'),(7,'Curl'),(8,'Deadlifts'),(9,'Dip'),(10,'Hyperextension'),(11,'Jerk'),(12,'Jump Rope'),(13,'Jumps'),(14,'Lunges'),(15,'Muscle-up'),(16,'N/A'),(17,'Presses'),(18,'Pull-up'),(19,'Push'),(20,'Push-up'),(21,'Rest'),(22,'Row'),(23,'Run'),(24,'Snatch'),(25,'Squats'),(26,'Static'),(27,'Strongman'),(28,'Swimming'),(29,'Swing'),(30,'Throw'),(31,'Thruster'),(32,'Walking');
/*!40000 ALTER TABLE `workout_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-05 10:51:36
