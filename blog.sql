/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50734
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 50734
 File Encoding         : 65001

 Date: 13/12/2022 14:10:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bozhu
-- ----------------------------
DROP TABLE IF EXISTS `bozhu`;
CREATE TABLE `bozhu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `bozhuzhanghao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博主账号',
  `mima` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `bozhuxingming` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博主姓名',
  `touxiang` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `xingbie` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `nianling` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `shouji` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `youxiang` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `bozhuzhanghao`(`bozhuzhanghao`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1615810580607 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '博主' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bozhu
-- ----------------------------
INSERT INTO `bozhu` VALUES (11, '2021-03-15 19:55:17', '博主1', '123456', '博主姓名1', 'http://localhost:8080/springboot60zv5/upload/bozhu_touxiang1.jpg', '男', 1, '13823888881', '773890001@qq.com');
INSERT INTO `bozhu` VALUES (12, '2021-03-15 19:55:17', '博主2', '123456', '博主姓名2', 'http://localhost:8080/springboot60zv5/upload/bozhu_touxiang2.jpg', '男', 2, '13823888882', '773890002@qq.com');
INSERT INTO `bozhu` VALUES (13, '2021-03-15 19:55:17', '博主3', '123456', '博主姓名3', 'http://localhost:8080/springboot60zv5/upload/bozhu_touxiang3.jpg', '男', 3, '13823888883', '773890003@qq.com');
INSERT INTO `bozhu` VALUES (14, '2021-03-15 19:55:17', '博主4', '123456', '博主姓名4', 'http://localhost:8080/springboot60zv5/upload/bozhu_touxiang4.jpg', '男', 4, '13823888884', '773890004@qq.com');
INSERT INTO `bozhu` VALUES (15, '2021-03-15 19:55:17', '博主5', '123456', '博主姓名5', 'http://localhost:8080/springboot60zv5/upload/bozhu_touxiang5.jpg', '男', 5, '13823888885', '773890005@qq.com');
INSERT INTO `bozhu` VALUES (16, '2021-03-15 19:55:17', '博主6', '123456', '博主姓名6', 'http://localhost:8080/springboot60zv5/upload/bozhu_touxiang6.jpg', '男', 6, '13823888886', '773890006@qq.com');
INSERT INTO `bozhu` VALUES (1615810391925, '2021-03-15 20:13:11', '1', '1', '陈一', 'http://localhost:8080/springboot60zv5/upload/1615810405246.jpg', '女', 22, '12345678978', '123@qq.com');
INSERT INTO `bozhu` VALUES (1615810580606, '2021-03-15 20:16:20', '2', '2', '王明', 'http://localhost:8080/springboot60zv5/upload/1615810595054.jpg', '男', 25, '12345645612', '159@qq.com');

-- ----------------------------
-- Table structure for chat
-- ----------------------------
DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `adminid` bigint(20) NULL DEFAULT NULL COMMENT '管理员id',
  `ask` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '提问',
  `reply` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回复',
  `isreply` int(11) NULL DEFAULT NULL COMMENT '是否回复',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1670909129766 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '在线客服' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat
-- ----------------------------
INSERT INTO `chat` VALUES (51, '2021-03-15 19:55:17', 1, 1, '提问1', '回复1', 1);
INSERT INTO `chat` VALUES (52, '2021-03-15 19:55:17', 2, 2, '提问2', '回复2', 2);
INSERT INTO `chat` VALUES (53, '2021-03-15 19:55:17', 3, 3, '提问3', '回复3', 3);
INSERT INTO `chat` VALUES (54, '2021-03-15 19:55:17', 4, 4, '提问4', '回复4', 4);
INSERT INTO `chat` VALUES (55, '2021-03-15 19:55:17', 5, 5, '提问5', '回复5', 5);
INSERT INTO `chat` VALUES (56, '2021-03-15 19:55:17', 6, 6, '提问6', '回复6', 6);
INSERT INTO `chat` VALUES (1615810114904, '2021-03-15 20:08:34', 1615809946983, NULL, '可以与管理员进行实时聊天沟通', NULL, 0);
INSERT INTO `chat` VALUES (1615810158625, '2021-03-15 20:09:18', 1615809946983, 1, NULL, '1', NULL);
INSERT INTO `chat` VALUES (1615810685689, '2021-03-15 20:18:05', 1615810580606, NULL, '可以与管理员进行实时沟通', NULL, 0);
INSERT INTO `chat` VALUES (1615810724028, '2021-03-15 20:18:44', 1615810580606, 1, NULL, '1', NULL);
INSERT INTO `chat` VALUES (1670909129765, '2022-12-13 13:25:29', 11, NULL, 'nh ', NULL, 1);

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配置文件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 'picture1', 'http://localhost:8080/springboot60zv5/upload/1615809593916.jpg');
INSERT INTO `config` VALUES (2, 'picture2', 'http://localhost:8080/springboot60zv5/upload/1615810325069.jpg');
INSERT INTO `config` VALUES (3, 'picture3', 'http://localhost:8080/springboot60zv5/upload/picture3.jpg');
INSERT INTO `config` VALUES (6, 'homepage', NULL);

-- ----------------------------
-- Table structure for discusswenzhangxinxi
-- ----------------------------
DROP TABLE IF EXISTS `discusswenzhangxinxi`;
CREATE TABLE `discusswenzhangxinxi`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `refid` bigint(20) NOT NULL COMMENT '关联表id',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `nickname` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
  `reply` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回复内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1670909402351 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章信息评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discusswenzhangxinxi
-- ----------------------------
INSERT INTO `discusswenzhangxinxi` VALUES (81, '2021-03-15 19:55:17', 1, 1, '用户名1', '评论内容1', '回复内容1');
INSERT INTO `discusswenzhangxinxi` VALUES (82, '2021-03-15 19:55:17', 2, 2, '用户名2', '评论内容2', '回复内容2');
INSERT INTO `discusswenzhangxinxi` VALUES (83, '2021-03-15 19:55:17', 3, 3, '用户名3', '评论内容3', '回复内容3');
INSERT INTO `discusswenzhangxinxi` VALUES (84, '2021-03-15 19:55:17', 4, 4, '用户名4', '评论内容4', '回复内容4');
INSERT INTO `discusswenzhangxinxi` VALUES (85, '2021-03-15 19:55:17', 5, 5, '用户名5', '评论内容5', '回复内容5');
INSERT INTO `discusswenzhangxinxi` VALUES (86, '2021-03-15 19:55:17', 6, 6, '用户名6', '评论内容6', '回复内容6');
INSERT INTO `discusswenzhangxinxi` VALUES (1615810093599, '2021-03-15 20:08:12', 1615809871262, 1615809946983, '2', '感情真挚，很不错的文章', '多谢捧场');
INSERT INTO `discusswenzhangxinxi` VALUES (1615810665572, '2021-03-15 20:17:45', 1615810493025, 1615810580606, '2', '写得不错，情感真挚流露', '多谢捧场');
INSERT INTO `discusswenzhangxinxi` VALUES (1670909181355, '2022-12-13 13:26:20', 31, 11, '博主1', 'bh', NULL);
INSERT INTO `discusswenzhangxinxi` VALUES (1670909402350, '2022-12-13 13:30:01', 1670909365495, 11, '博主1', 'aaa', NULL);

-- ----------------------------
-- Table structure for jubaotousu
-- ----------------------------
DROP TABLE IF EXISTS `jubaotousu`;
CREATE TABLE `jubaotousu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `biaoti` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `leixing` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `tupian` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `jubaoneirong` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '举报内容',
  `jubaoshijian` date NULL DEFAULT NULL COMMENT '举报时间',
  `bozhuzhanghao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '博主账号',
  `shouji` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机',
  `sfsh` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '否' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '审核回复',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1615810544100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '举报投诉' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jubaotousu
-- ----------------------------
INSERT INTO `jubaotousu` VALUES (41, '2021-03-15 19:55:17', '标题1', '类型1', 'http://localhost:8080/springboot60zv5/upload/jubaotousu_tupian1.jpg', '举报内容1', '2021-03-15', '博主账号1', '手机1', '是', '');
INSERT INTO `jubaotousu` VALUES (42, '2021-03-15 19:55:17', '标题2', '类型2', 'http://localhost:8080/springboot60zv5/upload/1615809561966.jpg', '举报内容2', '2021-03-15', '博主账号2', '手机2', '是', '');
INSERT INTO `jubaotousu` VALUES (43, '2021-03-15 19:55:17', '标题3', '类型3', 'http://localhost:8080/springboot60zv5/upload/jubaotousu_tupian3.jpg', '举报内容3', '2021-03-15', '博主账号3', '手机3', '是', '');
INSERT INTO `jubaotousu` VALUES (44, '2021-03-15 19:55:17', '标题4', '类型4', 'http://localhost:8080/springboot60zv5/upload/jubaotousu_tupian4.jpg', '举报内容4', '2021-03-15', '博主账号4', '手机4', '是', '');
INSERT INTO `jubaotousu` VALUES (45, '2021-03-15 19:55:17', '标题5', '类型5', 'http://localhost:8080/springboot60zv5/upload/jubaotousu_tupian5.jpg', '举报内容5', '2021-03-15', '博主账号5', '手机5', '是', '');
INSERT INTO `jubaotousu` VALUES (46, '2021-03-15 19:55:17', '标题6', '类型6', 'http://localhost:8080/springboot60zv5/upload/1615809576579.jpg', '举报内容6', '2021-03-15', '博主账号6', '手机6', '是', '');
INSERT INTO `jubaotousu` VALUES (1615810544099, '2021-03-15 20:15:43', '举报违规内容', '不良言论', 'http://localhost:8080/springboot60zv5/upload/1615810518881.jpg', '博主账号为UFGRD的博主发布不良言论的博客文章', '2021-03-15', '1', '12345678978', '是', 'ok');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `introduction` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '简介',
  `picture` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1615810366418 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统公告' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (71, '2021-03-15 19:55:17', '标题1', '简介1', 'http://localhost:8080/springboot60zv5/upload/news_picture1.jpg', '内容1');
INSERT INTO `news` VALUES (72, '2021-03-15 19:55:17', '标题2', '简介2', 'http://localhost:8080/springboot60zv5/upload/news_picture2.jpg', '内容2');
INSERT INTO `news` VALUES (73, '2021-03-15 19:55:17', '标题3', '简介3', 'http://localhost:8080/springboot60zv5/upload/1615809620404.jpg', '<p>内容3</p>');
INSERT INTO `news` VALUES (74, '2021-03-15 19:55:17', '标题4', '简介4', 'http://localhost:8080/springboot60zv5/upload/1615809629841.jpg', '<p>内容4</p>');
INSERT INTO `news` VALUES (75, '2021-03-15 19:55:17', '标题5', '简介5', 'http://localhost:8080/springboot60zv5/upload/news_picture5.jpg', '内容5');
INSERT INTO `news` VALUES (76, '2021-03-15 19:55:17', '标题6', '简介6', 'http://localhost:8080/springboot60zv5/upload/1615809640209.jpg', '<p>内容6</p>');
INSERT INTO `news` VALUES (1615810366417, '2021-03-15 20:12:45', '关于校园博客规范使用通知', '规范使用博客', 'http://localhost:8080/springboot60zv5/upload/1615810344631.jpg', '<p>不得发布不良言论的博客文章</p><p><img src=\"http://localhost:8080/springboot60zv5/upload/1615810363830.jpg\"></p>');

-- ----------------------------
-- Table structure for storeup
-- ----------------------------
DROP TABLE IF EXISTS `storeup`;
CREATE TABLE `storeup`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `refid` bigint(20) NULL DEFAULT NULL COMMENT '收藏id',
  `tablename` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收藏名称',
  `picture` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收藏图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1670909442198 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of storeup
-- ----------------------------
INSERT INTO `storeup` VALUES (1615810646849, '2021-03-15 20:17:26', 1615810580606, 1615810493025, 'wenzhangxinxi', '关于一个电影的日记', 'http://localhost:8080/springboot60zv5/upload/1615810470786.jpg');

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `tablename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表名',
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色',
  `token` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '新增时间',
  `expiratedtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'token表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of token
-- ----------------------------
INSERT INTO `token` VALUES (1, 11, '博主1', 'bozhu', '博主', 't0rgnxfm2s3uqwahrlh2679zqmtwmccf', '2021-03-15 19:56:13', '2022-12-13 06:46:17');
INSERT INTO `token` VALUES (2, 1, 'abo', 'users', '管理员', '3ccsuq878h41bifthqywzttg2pc26wk1', '2021-03-15 19:56:45', '2022-12-13 06:46:49');
INSERT INTO `token` VALUES (3, 1615809794300, '1', 'bozhu', '博主', 'x2il9laxqr5hyvq9pxvtalfm90ofq38u', '2021-03-15 20:03:19', '2021-03-15 21:09:26');
INSERT INTO `token` VALUES (4, 1615809946983, '2', 'bozhu', '博主', 'hh6fi8j7son5fnqu3itadcylizjca2uh', '2021-03-15 20:05:52', '2021-03-15 21:09:57');
INSERT INTO `token` VALUES (5, 1615810391925, '1', 'bozhu', '博主', '80hftvdmx0jc1pqg5xnns7jtj099b7zq', '2021-03-15 20:13:17', '2021-03-15 21:18:50');
INSERT INTO `token` VALUES (6, 1615810580606, '2', 'bozhu', '博主', 'bfg0335nnzq48p88ka2p3kd8jgcqwnp4', '2021-03-15 20:16:25', '2021-03-15 21:16:26');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `role` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '新增时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'wangbuer', 'wangbuer', '管理员', '2022-05-25 19:55:17');

-- ----------------------------
-- Table structure for wenzhangfenlei
-- ----------------------------
DROP TABLE IF EXISTS `wenzhangfenlei`;
CREATE TABLE `wenzhangfenlei`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `fenlei` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `fenlei`(`fenlei`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1615810309446 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wenzhangfenlei
-- ----------------------------
INSERT INTO `wenzhangfenlei` VALUES (21, '2021-03-15 19:55:17', '生活场景');
INSERT INTO `wenzhangfenlei` VALUES (22, '2021-03-15 19:55:17', '城镇景观');
INSERT INTO `wenzhangfenlei` VALUES (23, '2021-03-15 19:55:17', '旅游休闲');
INSERT INTO `wenzhangfenlei` VALUES (24, '2021-03-15 19:55:17', '美食');
INSERT INTO `wenzhangfenlei` VALUES (25, '2021-03-15 19:55:17', '服饰');
INSERT INTO `wenzhangfenlei` VALUES (26, '2021-03-15 19:55:17', '电影');
INSERT INTO `wenzhangfenlei` VALUES (1615810309445, '2021-03-15 20:11:48', '军训有感');

-- ----------------------------
-- Table structure for wenzhangxinxi
-- ----------------------------
DROP TABLE IF EXISTS `wenzhangxinxi`;
CREATE TABLE `wenzhangxinxi`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `wenzhangbiaoti` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章标题',
  `fenlei` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类',
  `tupian` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片',
  `wenzhangneirong` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文章内容',
  `faburiqi` date NULL DEFAULT NULL COMMENT '发布日期',
  `bozhuzhanghao` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '博主账号',
  `youxiang` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `clicktime` datetime(0) NULL DEFAULT NULL COMMENT '最近点击时间',
  `clicknum` int(11) NULL DEFAULT 0 COMMENT '点击次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1670909365496 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wenzhangxinxi
-- ----------------------------
INSERT INTO `wenzhangxinxi` VALUES (31, '2021-03-15 19:55:17', '文章标题1', '城镇景观', 'http://localhost:8080/springboot60zv5/upload/1615809478115.jpg', '<p>文章内容1</p>', '2021-03-15', '博主账号1', '邮箱1', '2022-12-13 05:26:53', 6);
INSERT INTO `wenzhangxinxi` VALUES (32, '2021-03-15 19:55:17', '文章标题2', '旅游休闲', 'http://localhost:8080/springboot60zv5/upload/1615809487708.jpg', '<p>文章内容2</p>', '2021-03-15', '博主账号2', '邮箱2', '2022-12-13 05:46:08', 4);
INSERT INTO `wenzhangxinxi` VALUES (33, '2021-03-15 19:55:17', '文章标题3', '服饰', 'http://localhost:8080/springboot60zv5/upload/1615809501958.jpg', '<p>文章内容3</p>', '2021-03-15', '博主账号3', '邮箱3', '2021-03-15 19:58:11', 4);
INSERT INTO `wenzhangxinxi` VALUES (34, '2021-03-15 19:55:17', '文章标题4', '生活场景', 'http://localhost:8080/springboot60zv5/upload/1615809522103.jpg', '<p>文章内容4</p>', '2021-03-15', '博主账号4', '邮箱4', '2021-03-15 19:58:25', 5);
INSERT INTO `wenzhangxinxi` VALUES (35, '2021-03-15 19:55:17', '文章标题5', '电影', 'http://localhost:8080/springboot60zv5/upload/1615809537763.jpg', '<p>文章内容5</p>', '2021-03-15', '博主账号5', '邮箱5', '2021-03-15 20:16:54', 11);
INSERT INTO `wenzhangxinxi` VALUES (36, '2021-03-15 19:55:17', '文章标题6', '美食', 'http://localhost:8080/springboot60zv5/upload/wenzhangxinxi_tupian6.jpg', '<p>文章内容6</p>', '2021-03-15', '博主账号6', '邮箱6', '2022-12-13 05:45:44', 10);
INSERT INTO `wenzhangxinxi` VALUES (1615810493025, '2021-03-15 20:14:52', '关于一个电影的日记', '电影', 'http://localhost:8080/springboot60zv5/upload/1615810470786.jpg', '<p><br></p><p>我喜爱的电影，寻找总是要费很大的功夫，得到却都显得极为偶然，应了一句古话“踏破铁鞋无觅处，得来全不费工夫”。</p><p><br></p><p>&nbsp;上一个寒假，也是无聊的小憩中，无聊地打开电视，看到了我希冀以久的电影“牧马人”，今天早晨起床很迟，想不能错过电视的好节目，一旦有自己想看的“城南旧事”错过了怎能不让人痛心——然而终于没有失去这次机会。我爱的这些个电影，在音像店里是找不到的。想我过去花了多大的功夫，从满怀希望到希望慢慢的消灭，走进一家音像店，又走出来，收获的只是梦寐难以成真的感慨。</p><p><br></p><p>&nbsp;大概像这样的好电影，人生难得拥有，它只能像过客，在你的珍视的目光下溜走，留下的只是那或清晰或模糊但一辈子都难忘一辈子都追寻的感情。</p><p><br></p><p>&nbsp;其实，像“牧马人”也好“城南旧事”也好，与我这偶然的聚首实是重逢。我第一次看“城南旧事”还是小学六年级的事情呢，那年给乡下爷爷奶奶买的彩色电视机还没有带回去，就停靠在我们一家拥挤的宿舍里。我只是看了一点点片断，但从此难忘。脑海里常常浮现出电影的一幕幕：黑黑的夜里风雨交加，马车踏着水声驶过，那个破旧的小院里，年轻人真挚的无奈的眼神···这次六七年前的邂逅，并没有使我对这部影片的情节懂得清楚，今天看来我那时留下来的印象是如此模糊，我的印象竟至忽略了秀贞的命运，忽略了宋妈的悲恸，忽略了英子爸爸的伤逝···我的脑海中只有模糊的荒园里面年轻人的形象，还有模糊的风雨的情景，旧庭院里昏黄的灯光，只此而已，但是却总难忘。</p>', '2021-03-15', '1', '123@qq.com', '2021-03-15 20:17:48', 3);

SET FOREIGN_KEY_CHECKS = 1;
