Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374619E985;
	Mon, 23 Sep 2024 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104467; cv=fail; b=MggOAWJqZdsP2HbATFdyrf25yw8g8HnUvcstkLWLdGadbW6NgjWpECOt27FiV6PwLI3K0bQXMiA9YSjv7gbs45/79I+uDF5lo+6A+DNLliEAEccEzcWHnySZX4l8qpNY40ubEJQERhnTTRoPNdOk5zBDjPZkH324eIrNc29FvY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104467; c=relaxed/simple;
	bh=rsykFz4qFSCLZxRBKGy6PH+d9MVb1awJdla4w9/W97A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ys7sbsQ4fg9+Df9VGDuUWj67QXxzjTUPbo0ATBaFD3p4O9kqCysrOwhGrggaBUutS0U0IzjRoTsKE7GCpZOD/gJullF09LZkSWm64wVJypzVrrFQbR9Wb16MZQJ7lyXa8/U3tcR5hkO9SvKwUSQ5vVfGTR5kwpGmaenaO/gXG2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DIWK7bwu; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DIWK7bwu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NBAH4H011416;
	Mon, 23 Sep 2024 15:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RyBq6IHimVmaNJBEtioa9nrREmNMIe9ltriKKtbXa0U=; b=DIWK7bwuqFAXRVVM
	nqrasrrXgWZx3X4XdnY3dbwxjOahmivTxE0ajKoM/iqDxB6axWejNlMFhjEpRWY6
	bbCKPA4nBJqCZv4RN4v/O8Sk7g/pzYJY296/sfPaWZZYsp+C97+aGv2UUd897D/U
	Sb4+t6yyXX4ut2aQUTg6MLWmmIfh5tacgnLV3JeeajDwMpdhF6ffA5VCsl8SYojP
	PXwRZBB5Ei+HA+O8cRiHqwkxKwyXJY0WUEb0ZnK99vIpBbwOFPjAGxvIouXLpOCd
	6uIdZ/Gvatlg4T/M5dl5FfUZo/ZHSxdki+DA9kxiVwrdRbvuCuzNhZX5lrQB0EeD
	dycE5A==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012032.outbound.protection.outlook.com [40.93.1.32])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41skuen9ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 15:14:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOdEE92J4qLPuJlRe2sNgw1vgumdSItASpS5cQWPmzELTy2mdx0epiQSFu6+B+9k5zEdbMBAqiHoNZu9VXc2MTYvlWlvnBFYBMSKEKeVnGh3U1/BCti6CimUMbSofAhJssgKr3GZdB7ODLah2UGNlZltskEm1SDlHRIf+V3APt/O7833w3qzl0BGOLYhEH7MitzMe6smmKTOO8uDK5DOx83NpmoGrbDeB+iFQa7qodMFTMyuH21rUj4L0gB6Jh7TgjJjuz2alAwHjVapBvc2qNOj6N7bXo/+As6pJL4t907MwMmaYhVbLCbnzwiyMd35ll0Odq3frFotXjwmIUc6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyBq6IHimVmaNJBEtioa9nrREmNMIe9ltriKKtbXa0U=;
 b=Y/Ugrl+8U6ifTvnxosXo8kNBbl+Z7moia5ZHvZGUyZD8NE9Ep4UccqeetCtxKCXUeGXZpBq1OmqSxswUDH3bzCnwbiO0ma5Xo4HAQ5GG844bo9+2z8TaTHTrbhi8Nk4jxaBHuvxw9ctJGw1IyXOGGBo02cMQVo6oTxX4M5qLXOUnQMQfnNmntHow4eM/pOL0qqxHeYTquyqtxuz/FL4lEN+VWOHr+f+KCFagVFQWHYBmV0KXaXucssJ6qzdf1tW8Td2Mu5b2xjNBhD6XoqlXgVkTCk5SzsZAMZPtg8C0X0MfuyGhNekV/Zp2Pd+JeiT9BeMoi6l7XJfZ7BSQ4zaCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by LV8PR02MB10019.namprd02.prod.outlook.com
 (2603:10b6:408:183::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 15:14:07 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 15:14:07 +0000
From: Brian Cain <bcain@quicinc.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Sid Manning <sidneym@quicinc.com>,
        Nathan
 Chancellor <nathan@kernel.org>
Subject: RE: [PATCH] hexagon: vdso: Fix build failure
Thread-Topic: [PATCH] hexagon: vdso: Fix build failure
Thread-Index: AQHbDb/gMIsFA8eSkEy1bE3del2LGLJlepuQ
Date: Mon, 23 Sep 2024 15:14:06 +0000
Message-ID:
 <CH3PR02MB10247D71B45A21D9785091A6BB86F2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240923135235.1159314-1-linux@roeck-us.net>
In-Reply-To: <20240923135235.1159314-1-linux@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|LV8PR02MB10019:EE_
x-ms-office365-filtering-correlation-id: a0a54019-d99d-4c7b-c236-08dcdbe25e4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pUQfxgZJVb5s1/OFlkdRj5Fnn+QcRGM2bDHwPmU+SxmLJ5hoclP/9uplS+tu?=
 =?us-ascii?Q?8aSArhKJ8OsdwhlnJdnaEsEX6QP/EY8W6NmVeoZ1x2V57qFgCy3g6jPyRd93?=
 =?us-ascii?Q?fDNtlGGCFXyjwWyB3AeHcQCN5o2JwJTCUQmpMsFw+UTaJ/oYIynV01iQVBtp?=
 =?us-ascii?Q?aI/8LPTI5xv0ng0u/M/84JjiZG1o5XKoOc1//WN2+FzETFsZ1UujMnkPk1J6?=
 =?us-ascii?Q?Levra0ceQoFl7jV/Ff7NfungAE/Ie0Z0eeMCWLqRgixTA1YDK+4eS4ddB63x?=
 =?us-ascii?Q?vHhMh7NFklJz5GL0NhUxhsJWdQPOAzmJ5M9f+CAfI/KF3HnZpbGgTfETspvx?=
 =?us-ascii?Q?NxOym488TtFMK8KDxu6DcJaKfl7zHOt5BFW3aoQQU6s/usy4by8xxcIJbzuX?=
 =?us-ascii?Q?crdh8mMBpvnBdxhgZ7YjS4yoQitgBTIYX1I31CC91UBNaY0jHWEqumd8xMwq?=
 =?us-ascii?Q?Qh5RIISMtatixn5UYRa1g6ZExuUvWQ2qHACMefzhXFzo66gCMfxVs7mTQZzq?=
 =?us-ascii?Q?CvBhaOislhF0tcK6VryLOmutYKrhf5lIU+f38MsOBiBd96bwrQOtCgpImVcJ?=
 =?us-ascii?Q?J1DpUBcujDqEwPQTLznXdPT/RxteeDCVTcn7tsLqLfQ6rGp3EhG+cknO5NBC?=
 =?us-ascii?Q?S0pk/LffZHa9qxFrgaalXdEDYlakNr97uZGnaZ2TYpNae1k82a3lVPpzaQ83?=
 =?us-ascii?Q?UgUflMEmulRZ9oAMrx9dVSHKy+p7A3nZi80zrHybX7pvdc5WfcTVZSOeXPFF?=
 =?us-ascii?Q?cS/96ThGDTYK1SC4rOYcQpq4q5Vp7QNjtmChgZWWH+qsVS6jDmMqW00cZkS3?=
 =?us-ascii?Q?PirVP2s3Z3zVwY5rRGXiyAr2vd7c+AdtzroSX7LSZJOuB5pNtw6cJzZD5lt/?=
 =?us-ascii?Q?MLLVFV2iHytpfIxPG21Lqyg48Qv/O8I3igl0eNJ2VkCzryhVsQ7NZugy0GPV?=
 =?us-ascii?Q?d0sQ0s2MOFsN4HgxlBqf6J919Fo0xLTLOh5wh8ryLfhDglTBDsjTooifIyME?=
 =?us-ascii?Q?y9EPwdkCiwSvyiFoCG74KGC6Z5Eu+k5D61DRMmv+EfTM7HyYkSedtKp8aBIt?=
 =?us-ascii?Q?eWEwJlCg5bZmnDSxNgl6VFxaTD+N1gLpKz5Eml+iUmuFbMFhvj2UKkCvrres?=
 =?us-ascii?Q?INj9Y0pCc485KneP3pZ3wCQwxgZY0MMaOJBo09XSz/DsTQksi0EppXz64IRX?=
 =?us-ascii?Q?AnhXwrin7gMj5h/ZcN7T80n6IaZMF4xCM9yCslD9unzK4dK9sfDx0n/oLS4g?=
 =?us-ascii?Q?vHlagxeaYZ4RiMoJbL3hj1PlI88gmGhk6hSNKk6Ba7TTko1oMM0ug1rJfa7B?=
 =?us-ascii?Q?ZO0fXagrxpOcWVYW9K8+BX5ROQP5MF4HnNc8uTytF5Omle1fEMj211j6odiq?=
 =?us-ascii?Q?nAJDofwn6e01ZlAik34GS7uqGxC4iyDXY7Vd2W9NN4BpPH1Khg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR02MB10247.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jgq22b6IdYQqg+xCXQnR87ONhbLProrHWp0PNPKBcytHb+MKIVBeQJ8w6sii?=
 =?us-ascii?Q?lMULl+zUKjTUw5deYsa2YvbiLobLyjnM+QpnUfOKeH6IYZRw3VtP1gmN2hBW?=
 =?us-ascii?Q?gjmqtmEP5ej+TNJ/2ElYc0SaHm0bWHezBNWi3ECU3+1EIGP3oA+9PdXWpeb9?=
 =?us-ascii?Q?Saw6AvD92dXK4pIqVaRc40Af4YKHOw2c17wSLj8rSGWYsX4Anzuqqr551ZF2?=
 =?us-ascii?Q?ZvL4PdymY2yPN7HmLX+xPBdWqku57/xz0VIHc1jarxJ5tBgHx0JUi0Osv9SA?=
 =?us-ascii?Q?hXZLPl7TJWAOjStM8GGEbHgQb/oykKG9TagBd9ntZayS5jOSPrv710dDRmCm?=
 =?us-ascii?Q?QtyrIB3I6/svtIWFN5dch97XxPQnWEGv+67lI0D8tDYu9Ate5+g9l4HAtmuf?=
 =?us-ascii?Q?pQKGA1nycNvIxyOEMezLbJxjhU/oqAfov2pPyqp/VdOfavZyaeJw7dqdSY64?=
 =?us-ascii?Q?QI4r4doKEiUZJZ06WB4KbP80Awoqu3c1bSXnKGDvkt49S13e4vU6jlD8E0QD?=
 =?us-ascii?Q?KyDF8dvmVnBVcS2yQFdhZoCv2D47m+PI45Z519BF/NDbV7wWEABgh7UUPTX0?=
 =?us-ascii?Q?cj26ZgH/ENfQ4R7sZOpnqoD0TArSWYS56jbRjUP/hH9TFINRhhPDtFGis5Bl?=
 =?us-ascii?Q?NLBx09/i9GFNADDYnsT1ZIV8omcLoH6dj2Vbc0W63lcgHy79ryNS77jGTjCY?=
 =?us-ascii?Q?C1nebgK4GvRIosmwaICStIAZRupLuWmlYXnxNvLZW+RcipFOfTq5AOQseVoP?=
 =?us-ascii?Q?cKs/1HOEGqqkkOtOqQBhLzxNzCfKgDBzQpYBNcCDjAx2KTinDeacsaBwI8Q7?=
 =?us-ascii?Q?U5DBXI2NSeiPCls6NP/p4jC/M2a0o7nexBi3rhzVqi1TY2h4Wp757lOTGteG?=
 =?us-ascii?Q?AhIoGMUW/GEkvDK5orE6cJMWWEnXL8d6w24VcJIZSKFClavljBJRe6uKzmad?=
 =?us-ascii?Q?jQEwsY0EZRM8+mVh5/oWgnZVMvw68IHQJWqFbhgx0phb+rDnukCZNM+hLfzb?=
 =?us-ascii?Q?zm+v337BsPxokqoNP1f+4XM4kPHDYI4J+Y5hJRegp5uI2V/b/YUJS5ppazHC?=
 =?us-ascii?Q?4Gy2qCf/6hJPEDxi3Cau0uyXDtP8b9Qq8eSAhLykvR0kwsqC9tHxqmGl/zDa?=
 =?us-ascii?Q?R0amv/n+PgCtJ2lJiexDJ0N/Mmnpq0Ap+MZ3U9sGUrrIDi8+wD/bRouXesfo?=
 =?us-ascii?Q?NoDo4hZSIH50uhphYxP1udJCWiVrpCIMsLGbsNLcXZF0rezThySQAfV5Mkim?=
 =?us-ascii?Q?pno5BdtbFBHCAtVtdpAE3ZW1Cw9nFVuElIkPfbJ7qFhPquWNFBWvFO9CUIdB?=
 =?us-ascii?Q?x1dx5wXcTMZRyaqILc9v3IWVM6nc8NfqGQa7Wsn+xOkamFw5FYRDn8BWWSyh?=
 =?us-ascii?Q?sU86UF2Kov/uhN6ImtYf6h6RlgD9ECbUA1THSbaGKb7RBEcCE4R+Eyle91d5?=
 =?us-ascii?Q?irl7SCADGQa5B6gPNZCOyFcdYanuhJ/UNRNdrnlKw/ck/NnTm17jocphw0c+?=
 =?us-ascii?Q?AGECVapiHAFZdeaW1kj3Og/EeoxGPgqf6DaKWNtWHPBgVVQrhOBOfSRZTaMj?=
 =?us-ascii?Q?NLYWuQ57BvW7hrk2FQ/hpVH2v/vF284ACNaSIad2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wY2fK7MjAEPo5i9VqT7s8bJAwTQ0VwJp5RmGijcVor49xUpX+0SK9PYNh1iMlZfX4qwQXF0pgE3+BQ6RDmp5VTzw4+F0mHqcdd+0AgYaJNEuI4RIAiZP9SMWc9wA2v3XyVOX20L+EO1/B5EVjnVIXmLhBpajy3QbZMJarw9msB7mEZbHgOZdMh1rmz+WQhpRwk8yn/l3nVeNUdQp/81alZOc3ihVs4G8ImdaIowpEN9/bYAKtCpkQ0Wfkv9ahQKq+NIDsUz/Ln+Ubi70oPUXDW0woQVfjaAdFx+GBzvCziokj0E0PQ76gWpubSvdczgyIuE+PJqPJw2AKSf+OaL7syizAiPsJKKmitHX+G+4GNguapyuaZt4bDi+6a3Wi2Td6e56FuHiGCLaHvqz6SAW+swmq77urX9UGo6FY4Ui5uSV57wmVVmM4OxwE3wF47zVqWQGB+sLr3CgkPtuf6jGCD8OkUYlsYrVC8SMqxHyBOB/EIfjANwFFywN/YOuIUcEKm/1yPuxmIY21JrSsrxjj1Y5HHGfawSpfJQxFLRo4ExjE7j8ZFV8uHGpYOQvOx2LKJEpIVTMlSfDuD2/X8gpqrQtQ4qz8jHU3nWchG2OwYKCZg06LukxS0uhSd2xAh+3
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a54019-d99d-4c7b-c236-08dcdbe25e4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 15:14:07.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tXWQp6Kv6HCUcrQZ4Zk9PD46tthgbq1vGB4SGNyYQq1kc85sj55Yy7kEVLGhL3NMTJQsDVZhy/8U3lI/YlUjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10019
X-Proofpoint-GUID: rxCXiz_1fkDbGUQy2D96EsQXtTu_Wd8F
X-Proofpoint-ORIG-GUID: rxCXiz_1fkDbGUQy2D96EsQXtTu_Wd8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=569 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230113

> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Monday, September 23, 2024 8:53 AM
> To: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org; linux-kernel@vger.kernel.org; Guenter
> Roeck <linux@roeck-us.net>; Linus Torvalds <torvalds@linux-foundation.org=
>
> Subject: [PATCH] hexagon: vdso: Fix build failure
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> Hexagon images fail to build with the following error.
>=20
> arch/hexagon/kernel/vdso.c:57:3: error: use of undeclared identifier 'nam=
e'
>                 name =3D "[vdso]",
>                 ^
>=20
> Add the missing '.' to fix the problem.
>=20
> Fixes: 497258dfafcc ("mm: remove legacy install_special_mapping() code")
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Reviewed-by: Brian Cain <bcain@quicinc.com>

>  arch/hexagon/kernel/vdso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/hexagon/kernel/vdso.c b/arch/hexagon/kernel/vdso.c
> index 6fd27ff1df73..8119084dc519 100644
> --- a/arch/hexagon/kernel/vdso.c
> +++ b/arch/hexagon/kernel/vdso.c
> @@ -54,7 +54,7 @@ int arch_setup_additional_pages(struct linux_binprm
> *bprm, int uses_interp)
>         struct vm_area_struct *vma;
>         struct mm_struct *mm =3D current->mm;
>         static struct vm_special_mapping vdso_mapping =3D {
> -               name =3D "[vdso]",
> +               .name =3D "[vdso]",
>         };
>=20
>         if (mmap_write_lock_killable(mm))
> --
> 2.45.2
>=20

