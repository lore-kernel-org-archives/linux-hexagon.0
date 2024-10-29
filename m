Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728B1361;
	Tue, 29 Oct 2024 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212252; cv=fail; b=jNBYbyrEAQYR7mzUgMJK3zAf9RcOnfpSRF2ntqeBJnh5s4tKvB8YeXsMYYPvkgeJwoQmuhwVWeKB8Ve5Za3EtlnUwqJrsZSlxRVfsR9z+NcQw8FcawfGMNpC7TLx+yO5raiJzu6/I8/U6tU8sNsUqNH82NyqOaKHUlGgBLkZpdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212252; c=relaxed/simple;
	bh=jDsLvLhUQGJcps+4CLd640ug26CWZGxOBdpwRXcRoH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BfGCviqQlPgCZM9xsNNijZLfZaXyP4Wmn/F1/TFSFx42697A4k2a9sYs9Qv0H6cwUA8rUEtmHM/vydxydhlfqHg14o+BN1X0AlO1/0EBV1rtJ7Aka3r6zcCQrkEFtw5m8oJekpRG397ZfJKKKrWOFBvWvdt55LjODKX2ntd202E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FtVZz8+Z; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FtVZz8+Z"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TApdRE031126;
	Tue, 29 Oct 2024 14:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p+7wxQBiuXMvFzoNBTjIJSTelyQ7lM0sepQGPuR0ohk=; b=FtVZz8+ZnTwK2FGA
	yyZMLjvaI1fQAs4GW9ukXwseXZhPFIUo66lA6fHKCU58Pvlnmz1mFee1f7FT2neL
	fmbOLBsArXNFc2ci+Ra9sDixDOxsEVP4aN/xkGt8PdnGcYCghjAFIdvCVHb7UTNt
	DURulmTxO2h9xHYHa1HKdQVBg2237ZUcfK3qP+AHqXnwoCps7im7WZs4nEuvbmax
	yaWg6Pq5kA1qf1U78tV+7MYvI1c8eYWpbaM0Ecnd8Sy9GFBrQFMHyfDCE/RoYxQ3
	7Fkj/oUziTCFUc/8fQewL/dxI7J8MBv2HjVly2y/4R/4MiOrBt9d1wAu8D8Ufwpc
	L1Z11w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012011.outbound.protection.outlook.com [40.93.14.11])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gskk0jfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 14:30:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU4WY1mEvqf4ZazZUOZgP6khciKcEGjTb9HEY9Vc564y/AV5WQPY5+5vChnq4Mf9hDdKHQsc0ZI/mcDgJyuz7mY+PscNxYQJ3edgV/Z0fHjWW0X3kiiJfZrSEGqdWWkI1vENhZovX1rjkY0qaV9nouN9kQORKo6LtNdpkBnwSl5/2y/MkzvSH0R9aYGNGyICdifrKAo0UObrv5SjHCGJJTJ+wnGRlaSM3ZSrmZ0kDvyqGB3UUeoORH3BP7AdI7691pXDMQnYRRnUCUJprbVjM+OmynrXSmispElMSoXPi/t9Y4GuqSu2WbgddK30l7ODwde+76cy/mSsN/kJO8Jqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+7wxQBiuXMvFzoNBTjIJSTelyQ7lM0sepQGPuR0ohk=;
 b=pu2APxhSm1NifokfFEmNqyadzZcujbE8O8bEhT07H64OshCKrz0plSYyq33CnK9zmOdc30wGR+i82zVQVpT3XPV34NvvMSBrMw2+5A5K+muAS30s76/Y/dz9kQOfuMtp9JCGpM6EHbXSa2ercI8XTD09vl4Ua/bCEQIHpLfPGUzBZcgpIw6ncDU6Zbm59nPkIhHVWKRNVZIvV2ARjK8oygEuLNXjFc79+iELlwMGUspHvj/ol3usLHFdJk1eneCi2fhL9zt6ANvNmgs8Wkv07WjYoEYRxfcEFL9/EFZNlNv/wEA9IOGRf8SuUv5Vl0moeUcBy6IX0zDj9KGr4X4SUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by SA3PR02MB9996.namprd02.prod.outlook.com
 (2603:10b6:806:37d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 14:30:31 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11%7]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 14:30:30 +0000
From: Brian Cain <bcain@quicinc.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Niklas Schnelle
	<schnelle@linux.ibm.com>,
        "linux-hexagon@vger.kernel.org"
	<linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hexagon: simplify asm/io.h for !HAS_IOPORT
Thread-Topic: [PATCH] hexagon: simplify asm/io.h for !HAS_IOPORT
Thread-Index: AQHbKX4jm5qr1mkgK0q21ngDWvSuYLKdyx3Q
Date: Tue, 29 Oct 2024 14:30:30 +0000
Message-ID:
 <CH3PR02MB10247354241E387EFD39D4892B84B2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20241028211227.2294887-1-arnd@kernel.org>
In-Reply-To: <20241028211227.2294887-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|SA3PR02MB9996:EE_
x-ms-office365-filtering-correlation-id: 4d081ade-d3ae-4dc8-82a5-08dcf8263d8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rBR60o+UQ//j4NrPDk/QwURUEi1jmgYRagw2ut4rVfgFCozzohYUnjwWh4FR?=
 =?us-ascii?Q?OJ7RYkyKiRQUaAnFw3JgCdZD9iMVbdHLguwfqZjFBy1RFmj4Ru9tcZvOZAil?=
 =?us-ascii?Q?XNoO4vR47QEK0C+TzaCxIOoH7UWXVmt61OcD0RKzxZSWCr8tEF8JT1paUB0P?=
 =?us-ascii?Q?j/ePhBKDkVdPfP2wCdxTb9Owh+H8BqblZhZ63SCxntnyIABBnyEqXqfQNcXd?=
 =?us-ascii?Q?LI1Dwdope2sqFMhKeW+mBoCRAC4ZyCZ5AcwvYY9v7Mm+e7dncxuFiRCqRnKJ?=
 =?us-ascii?Q?QR1dyy1puIjMp1/Drll8OKJLyKCoZ8F5LzwS2iB9CNBZXZ8kyvMwat8YC5qj?=
 =?us-ascii?Q?DNLWZoNBOfcSAbUE5CVJtEqTxTagCln9qZq7bFadWIqa0aqO2H4vrLpsmZm4?=
 =?us-ascii?Q?00cn882nZyVM5+6KOeq8gAMx+5HUWYWw6Z+Ta8SUliw2PME6L3leoIonR2zP?=
 =?us-ascii?Q?0w3cOH/olGRUYK0c7g9Fj6MrU1D5Bbf+RQZDx5u7f/3a86tmBhkdDtsXngkJ?=
 =?us-ascii?Q?LgW1WFdbptY1wmcdqauMGX0TLsdMD7dH2K6cQUraKZsBgXeTDaslkkMYV/Eu?=
 =?us-ascii?Q?s4qfxw2zHWod3ktkByyGsxGrTDgZ/SMKcn6wUBhUgwKIbATsDvsSqh+CQ7V0?=
 =?us-ascii?Q?lVtsQRqfQ+zjyNiCKgk0GiOQ0p2anoz1ygSJHpPsS3JPZ2bl/XDPXyMV1s1j?=
 =?us-ascii?Q?BtXGU88r1+2trlHdeGLUhaYel2W/Bte8C3Qy+6qa/pOLd00YVcvdjbm6MaBp?=
 =?us-ascii?Q?eUcLk6ZQIh5cYW4rGzCdSYeOAG9hA7dpma2/HnXX8FplY6xFnkNLqt5HfYhP?=
 =?us-ascii?Q?/OxTGJGbBiY7ZjxoCIAgDjOeMcDJ3goXYhseTpiHcN7nc+o0FQbGNjuiF9fK?=
 =?us-ascii?Q?Nsd3baWJmSpUKROuMVpcrofmwXq/zhoiOGLUQyRCltp8w620f+4c3r4g4LN4?=
 =?us-ascii?Q?FF5snbRYxWdwCkEyExBe1uxxamx+8fcVIzdIok1kJjrJpbEIfVU+ZuptEFvm?=
 =?us-ascii?Q?wv+F3Fx9YrVsEr8cD8K+3kWg9+bFrzvp/O/G6SeqE9RPz0/YJ64cBaZmTjuZ?=
 =?us-ascii?Q?Niq48TDeMiaX6TWNgumgLccbk6l4x0QeQ9AUABfQwr19S1Atx2SEAGm2QvBk?=
 =?us-ascii?Q?iNhyTnTBBJ2HzWbEMTGqcekHaD2zRyWHwYAaQ7aul1tvRtRdVIKpR8uGpFyM?=
 =?us-ascii?Q?+nkxiXOieTiGGbohOM76ePRilrkudLGMGK1xD2/fv+ATLNgh0lgriYGnZUgQ?=
 =?us-ascii?Q?pLKvQ7VHn8eYuRIJWmztHB80gpmZPfqS2MMO0Bu400TeWfjngnrvhUyfFb0B?=
 =?us-ascii?Q?BrmxWqe6WAlUBoUD/NYd2GSK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR02MB10247.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y2AsH8gnASsJ7NCwgh8c+0a0Yq2uU3UF8HryIo4L9VIlujQsiy0krSJZSl8i?=
 =?us-ascii?Q?/8BBKfalH7yv8WA2H7OqMlpEqR6+eftDAwDcTMBkQ03vbheZDHmqduxkBWyj?=
 =?us-ascii?Q?qV4bU0bhlu00yigGwsxI62cBEev26KS4OHz0PtDoJL1CkzSEndvnrkWo1Oqp?=
 =?us-ascii?Q?mArhNNdpiOuvC3gzEXi6OdQ0OMwhLz1dL/WB01Ih/e/XzNefuaGC9qs5Xxcg?=
 =?us-ascii?Q?ekal+3sQbKvGmrOQmwIEKJQBRtdiMPx0TABEA15Yn8QnwmxDaQHcsa5i3tUk?=
 =?us-ascii?Q?v0001aCqCHqs8E1dMAdVJ/MMvxixQnwMJeG8bHIyicOqAaI1g4lZmV9We6r5?=
 =?us-ascii?Q?CIEo4b9sHS62IJWKcAjThwcw2ao5qB8/oaPSw8DS43WEJachuBACbxlI13L9?=
 =?us-ascii?Q?Ujs2Ik2v5MP8dEYsU4DNPcDyPBIEX42QTnqd7UAlK8SwpR+zQO87AeWkA+hT?=
 =?us-ascii?Q?US7nDNOKxM7wVyS0hdsthnBTDcCSi1/X2erhJgobKZUGQR58M4s8sDOzBUh6?=
 =?us-ascii?Q?Ak1OZjBpy23Qkn+RI4wXRBYmefIALkHX8nTV6/gCOhZkw1hpi2qtVOWcK01t?=
 =?us-ascii?Q?2RXM/BiI2WMhZvek5afujSLiCWyNpQYxT3jd0VJa0wuiA1URsNzHIh+S66Cz?=
 =?us-ascii?Q?9T5zylOrJ/uYnjM7Nk5ARXwPpeMYdNtaC1vTuG4Gro2ekz+e2FC/U68iG4//?=
 =?us-ascii?Q?9HWwPnZBGJIm++ZLppprBsUQwHYqPgTIT0PU0aPUEtLUQsuKDjBQQvPpNuWH?=
 =?us-ascii?Q?EScZdHJsmDzYC2cp20aIC0Qhj+7dmoAQttD6mDRJRWHII2wYmEPxTWQSddye?=
 =?us-ascii?Q?h/vduL+5EBLfMvZpl1wqZl+O12WEnX4HkRawCw/5wmPjDPHY6F8U3N8yXvT3?=
 =?us-ascii?Q?mkgvjv7796CgGgqkx6S4y2zmReSippgJJmaEXVGMPHJ2ZaSFwk+NavyPq0zG?=
 =?us-ascii?Q?FxPZp/ut9i3o10aXo9JWtSNNGXRekmnEWaYjr4dMQ+Hs8j0jjO8/KSA7DB3H?=
 =?us-ascii?Q?+saChqGAB0VLqRZv98Jl/EL0RKTlLQlTvsMxT0zi+6lJi4fpmytTfUd/Dubk?=
 =?us-ascii?Q?GibpBHFe96r+nWjv/ic8Fea6u9rsJaqPuQtRMBOqlUzR9k4IoRCGDW+f7Wcp?=
 =?us-ascii?Q?CsBsqCnPSfhCQq1oJD+YnVj13zULS/Fll5fkSu+eOgeX++MSPeq2MyhHAUTh?=
 =?us-ascii?Q?YZ5VTyCQTKfltOslNwwZT2t0/zB/kAY4x9t75hmhsP6w9cs5CXZEEEmxvr6W?=
 =?us-ascii?Q?jy3Np/5VniyB3PFHI8eriV6d4erH3mcuAKERSOR+UIlSq8QmQLUUY7YrQVxl?=
 =?us-ascii?Q?8hlJfFJWQ8+mvjyOGqViloUKF7WJ7XgFSAHHZ9s57EQVSvz/9pIGnPa6T0PK?=
 =?us-ascii?Q?tBJgv2fCxvgnOh5dPs/gGr2BLJDetDOQv9caWbGoK7jAp0feLCHwzN3UthJQ?=
 =?us-ascii?Q?wDQhaOlbHlkKguZx29SswLR+vo0oSnLb/RQGae4WI9qxlqnjBHmUxAcRtH9s?=
 =?us-ascii?Q?bglKEpF52rsuVNNuaflXvZ6xbqIScG1srPe70Rt/lVt/uZXnNAyeW70+FaAz?=
 =?us-ascii?Q?sVgk+Z611cTApObRoqQ=3D?=
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
	gBUGn9qjlWI2UQM7kMTZ4Qry+AyhHt5FE9lajwuXjthpfPwwMSvzdiM9IEPBSWmn37IQDHIP87mIKBvC7EvB/IPd6X1VW6YAtxHqTeN8dmhsEH+yzEbGm/vn17FVqsi3RlcQquaoREGPu2Mik1VUB9Gi3Ux7gn9hI00FIBhkCpw6KVHe4qCLCu99Sch2tY56P6/X4GQKeajZSUL31qlMtn+YVbfGUfRyYV3drQv8oTh+YVYppINd7yRfoxb1G+vfWRyGITEdxNJIOvuY1Vec9BdWAqiXyKZrsckx7p8QTF4iL0yH1CpvM+X13D/fr7gH8LebQe3n39wXNu+Ax/bBLRmrPf4btW3UXKvCi7GCeooOejr7DwRg8Wfs4e6BcGkKRERHt6TX2JSzEAF+6jnqchEDfTbm7HwFiiVOhJCryApcx/wgoK3zQ4+4ZwSPqbvvAxM8ibiS5NxGbDNSzSWyXy7ksFfIvQ7wsyu/Y8UchK46wg7VSRy9b0F6iJadgKg+IixlAKHxWFCEfC9Z5AoExnVjS27t+wCGN9v62ZbG9CjDdA0YLZ2kAOcBGDtjtMK7qNfTdJqcACgEqVB1usGzBpQp9t7D7OcOPkH6MuG+MydofRF50grbmxAJaWMqzrnW
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d081ade-d3ae-4dc8-82a5-08dcf8263d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 14:30:30.4266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tiOpKY07glggWNOlwwEDeQbmNKLdtVaAEyEIpiEK44pvgTnuboQbv1io7O+7yQh8+MEkwFmvVK9DBHCB5+LreQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9996
X-Proofpoint-GUID: lSERGPShMjFpCmRVAQ0_GbXwpR7Kc8l1
X-Proofpoint-ORIG-GUID: lSERGPShMjFpCmRVAQ0_GbXwpR7Kc8l1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=476 bulkscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290110



> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Monday, October 28, 2024 4:12 PM
> To: Brian Cain <bcain@quicinc.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Randy Dunlap
> <rdunlap@infradead.org>; Masahiro Yamada <masahiroy@kernel.org>; Niklas
> Schnelle <schnelle@linux.ibm.com>; linux-hexagon@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] hexagon: simplify asm/io.h for !HAS_IOPORT
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Hexagon fails to build after the final patch that makes CONFIG_HAS_IOPORT
> optional:
>=20
> In file included from arch/hexagon/include/asm/io.h:328:
> include/asm-generic/io.h:854:18: error: static declaration of 'ioread8' f=
ollows
> non-static declaration
>   854 | static inline u8 ioread8(const volatile void __iomem *addr)
>       |                  ^
> include/asm-generic/io.h:853:17: note: expanded from macro 'ioread8'
>   853 | #define ioread8 ioread8
>       |                 ^
> include/asm-generic/iomap.h:29:21: note: previous declaration is here
>    29 | extern unsigned int ioread8(const void __iomem *);
>       |                     ^
>=20
> As it turns out, most of its asm/io.h and lib/io.c files is redundant now=
,
> and just removing all that makes it build again.
>=20
> As with the other architectures, defining the __raw_readl()/__raw_writel(=
)
> type functions instead of the non-__raw ones is better here for consisten=
cy.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Brian Cain <bcain@quicinc.com>

> ---
> I've applied this in the asm-generic tree on top of the HAS_IOPORT series
> as a fixup, let me know if I should change anything.
>=20
>  arch/hexagon/Kconfig          |   4 +-
>  arch/hexagon/include/asm/io.h | 223 ++--------------------------------
>  arch/hexagon/lib/Makefile     |   2 +-
>  arch/hexagon/lib/io.c         |  82 -------------
>  4 files changed, 16 insertions(+), 295 deletions(-)
>  delete mode 100644 arch/hexagon/lib/io.c
>=20
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index 5ea1bf4b7d4f..3eb51fbe804e 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -30,7 +30,6 @@ config HEXAGON
>         select HAVE_ARCH_KGDB
>         select HAVE_ARCH_TRACEHOOK
>         select NEED_SG_DMA_LENGTH
> -       select NO_IOPORT_MAP
>         select GENERIC_IOREMAP
>         select GENERIC_SMP_IDLE_THREAD
>         select STACKTRACE_SUPPORT
> @@ -58,6 +57,9 @@ config EARLY_PRINTK
>  config MMU
>         def_bool y
>=20
> +config NO_IOPORT_MAP
> +       def_bool y
> +
>  config GENERIC_CSUM
>         def_bool y
>=20
> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.=
h
> index 522d321ea85a..83b2eb5de60c 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -8,38 +8,13 @@
>  #ifndef _ASM_IO_H
>  #define _ASM_IO_H
>=20
> -#ifdef __KERNEL__
> -
>  #include <linux/types.h>
> -#include <asm/iomap.h>
>  #include <asm/page.h>
>  #include <asm/cacheflush.h>
>=20
> -/*
> - * We don't have PCI yet.
> - * _IO_BASE is pointing at what should be unused virtual space.
> - */
> -#define IO_SPACE_LIMIT 0xffff
> -#define _IO_BASE ((void __iomem *)0xfe000000)
> -
> -#define IOMEM(x)        ((void __force __iomem *)(x))
> -
>  extern int remap_area_pages(unsigned long start, unsigned long phys_addr=
,
>                                 unsigned long end, unsigned long flags);
>=20
> -/* Defined in lib/io.c, needed for smc91x driver. */
> -extern void __raw_readsw(const void __iomem *addr, void *data, int
> wordlen);
> -extern void __raw_writesw(void __iomem *addr, const void *data, int
> wordlen);
> -
> -extern void __raw_readsl(const void __iomem *addr, void *data, int
> wordlen);
> -extern void __raw_writesl(void __iomem *addr, const void *data, int
> wordlen);
> -
> -#define readsw(p, d, l)        __raw_readsw(p, d, l)
> -#define writesw(p, d, l) __raw_writesw(p, d, l)
> -
> -#define readsl(p, d, l)   __raw_readsl(p, d, l)
> -#define writesl(p, d, l)  __raw_writesl(p, d, l)
> -
>  /*
>   * virt_to_phys - map virtual address to physical
>   * @address:  address to map
> @@ -58,21 +33,12 @@ static inline void *phys_to_virt(unsigned long addres=
s)
>         return __va(address);
>  }
>=20
> -/*
> - * IO port access primitives.  Hexagon doesn't have special IO access
> - * instructions; all I/O is memory mapped.
> - *
> - * in/out are used for "ports", but we don't have "port instructions",
> - * so these are really just memory mapped too.
> - */
> -
>  /*
>   * readb - read byte from memory mapped device
>   * @addr:  pointer to memory
>   *
> - * Operates on "I/O bus memory space"
>   */
> -static inline u8 readb(const volatile void __iomem *addr)
> +static inline u8 __raw_readb(const volatile void __iomem *addr)
>  {
>         u8 val;
>         asm volatile(
> @@ -82,8 +48,9 @@ static inline u8 readb(const volatile void __iomem *add=
r)
>         );
>         return val;
>  }
> +#define __raw_readb __raw_readb
>=20
> -static inline u16 readw(const volatile void __iomem *addr)
> +static inline u16 __raw_readw(const volatile void __iomem *addr)
>  {
>         u16 val;
>         asm volatile(
> @@ -93,8 +60,9 @@ static inline u16 readw(const volatile void __iomem
> *addr)
>         );
>         return val;
>  }
> +#define __raw_readw __raw_readw
>=20
> -static inline u32 readl(const volatile void __iomem *addr)
> +static inline u32 __raw_readl(const volatile void __iomem *addr)
>  {
>         u32 val;
>         asm volatile(
> @@ -104,6 +72,7 @@ static inline u32 readl(const volatile void __iomem
> *addr)
>         );
>         return val;
>  }
> +#define __raw_readl __raw_readl
>=20
>  /*
>   * writeb - write a byte to a memory location
> @@ -111,7 +80,7 @@ static inline u32 readl(const volatile void __iomem
> *addr)
>   * @addr:  pointer to memory
>   *
>   */
> -static inline void writeb(u8 data, volatile void __iomem *addr)
> +static inline void __raw_writeb(u8 data, volatile void __iomem *addr)
>  {
>         asm volatile(
>                 "memb(%0) =3D %1;"
> @@ -120,8 +89,9 @@ static inline void writeb(u8 data, volatile void __iom=
em
> *addr)
>                 : "memory"
>         );
>  }
> +#define __raw_writeb __raw_writeb
>=20
> -static inline void writew(u16 data, volatile void __iomem *addr)
> +static inline void __raw_writew(u16 data, volatile void __iomem *addr)
>  {
>         asm volatile(
>                 "memh(%0) =3D %1;"
> @@ -131,8 +101,9 @@ static inline void writew(u16 data, volatile void
> __iomem *addr)
>         );
>=20
>  }
> +#define __raw_writew __raw_writew
>=20
> -static inline void writel(u32 data, volatile void __iomem *addr)
> +static inline void __raw_writel(u32 data, volatile void __iomem *addr)
>  {
>         asm volatile(
>                 "memw(%0) =3D %1;"
> @@ -141,26 +112,7 @@ static inline void writel(u32 data, volatile void
> __iomem *addr)
>                 : "memory"
>         );
>  }
> -
> -#define __raw_writeb writeb
> -#define __raw_writew writew
> -#define __raw_writel writel
> -
> -#define __raw_readb readb
> -#define __raw_readw readw
> -#define __raw_readl readl
> -
> -/*
> - * http://comments.gmane.org/gmane.linux.ports.arm.kernel/117626
> - */
> -
> -#define readb_relaxed __raw_readb
> -#define readw_relaxed __raw_readw
> -#define readl_relaxed __raw_readl
> -
> -#define writeb_relaxed __raw_writeb
> -#define writew_relaxed __raw_writew
> -#define writel_relaxed __raw_writel
> +#define __raw_writel __raw_writel
>=20
>  /*
>   * I/O memory mapping functions.
> @@ -168,140 +120,6 @@ static inline void writel(u32 data, volatile void
> __iomem *addr)
>  #define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
>                        (__HEXAGON_C_DEV << 6))
>=20
> -#define __raw_writel writel
> -
> -static inline void memcpy_fromio(void *dst, const volatile void __iomem =
*src,
> -       int count)
> -{
> -       memcpy(dst, (void *) src, count);
> -}
> -
> -static inline void memcpy_toio(volatile void __iomem *dst, const void *s=
rc,
> -       int count)
> -{
> -       memcpy((void *) dst, src, count);
> -}
> -
> -static inline void memset_io(volatile void __iomem *addr, int value,
> -                            size_t size)
> -{
> -       memset((void __force *)addr, value, size);
> -}
> -
> -#define PCI_IO_ADDR    (volatile void __iomem *)
> -
> -/*
> - * inb - read byte from I/O port or something
> - * @port:  address in I/O space
> - *
> - * Operates on "I/O bus I/O space"
> - */
> -static inline u8 inb(unsigned long port)
> -{
> -       return readb(_IO_BASE + (port & IO_SPACE_LIMIT));
> -}
> -
> -static inline u16 inw(unsigned long port)
> -{
> -       return readw(_IO_BASE + (port & IO_SPACE_LIMIT));
> -}
> -
> -static inline u32 inl(unsigned long port)
> -{
> -       return readl(_IO_BASE + (port & IO_SPACE_LIMIT));
> -}
> -
> -/*
> - * outb - write a byte to a memory location
> - * @data: data to write to
> - * @addr:  address in I/O space
> - */
> -static inline void outb(u8 data, unsigned long port)
> -{
> -       writeb(data, _IO_BASE + (port & IO_SPACE_LIMIT));
> -}
> -
> -static inline void outw(u16 data, unsigned long port)
> -{
> -       writew(data, _IO_BASE + (port & IO_SPACE_LIMIT));
> -}
> -
> -static inline void outl(u32 data, unsigned long port)
> -{
> -       writel(data, _IO_BASE + (port & IO_SPACE_LIMIT));
> -}
> -
> -#define outb_p outb
> -#define outw_p outw
> -#define outl_p outl
> -
> -#define inb_p inb
> -#define inw_p inw
> -#define inl_p inl
> -
> -static inline void insb(unsigned long port, void *buffer, int count)
> -{
> -       if (count) {
> -               u8 *buf =3D buffer;
> -               do {
> -                       u8 x =3D inb(port);
> -                       *buf++ =3D x;
> -               } while (--count);
> -       }
> -}
> -
> -static inline void insw(unsigned long port, void *buffer, int count)
> -{
> -       if (count) {
> -               u16 *buf =3D buffer;
> -               do {
> -                       u16 x =3D inw(port);
> -                       *buf++ =3D x;
> -               } while (--count);
> -       }
> -}
> -
> -static inline void insl(unsigned long port, void *buffer, int count)
> -{
> -       if (count) {
> -               u32 *buf =3D buffer;
> -               do {
> -                       u32 x =3D inw(port);
> -                       *buf++ =3D x;
> -               } while (--count);
> -       }
> -}
> -
> -static inline void outsb(unsigned long port, const void *buffer, int cou=
nt)
> -{
> -       if (count) {
> -               const u8 *buf =3D buffer;
> -               do {
> -                       outb(*buf++, port);
> -               } while (--count);
> -       }
> -}
> -
> -static inline void outsw(unsigned long port, const void *buffer, int cou=
nt)
> -{
> -       if (count) {
> -               const u16 *buf =3D buffer;
> -               do {
> -                       outw(*buf++, port);
> -               } while (--count);
> -       }
> -}
> -
> -static inline void outsl(unsigned long port, const void *buffer, int cou=
nt)
> -{
> -       if (count) {
> -               const u32 *buf =3D buffer;
> -               do {
> -                       outl(*buf++, port);
> -               } while (--count);
> -       }
> -}
> -
>  /*
>   * These defines are necessary to use the generic io.h for filling in
>   * the missing parts of the API contract. This is because the platform
> @@ -310,23 +128,6 @@ static inline void outsl(unsigned long port, const v=
oid
> *buffer, int count)
>   */
>  #define virt_to_phys virt_to_phys
>  #define phys_to_virt phys_to_virt
> -#define memset_io memset_io
> -#define memcpy_fromio memcpy_fromio
> -#define memcpy_toio memcpy_toio
> -#define readb readb
> -#define readw readw
> -#define readl readl
> -#define writeb writeb
> -#define writew writew
> -#define writel writel
> -#define insb insb
> -#define insw insw
> -#define insl insl
> -#define outsb outsb
> -#define outsw outsw
> -#define outsl outsl
>  #include <asm-generic/io.h>
>=20
> -#endif /* __KERNEL__ */
> -
>  #endif
> diff --git a/arch/hexagon/lib/Makefile b/arch/hexagon/lib/Makefile
> index a64641e89d5f..107894c0910e 100644
> --- a/arch/hexagon/lib/Makefile
> +++ b/arch/hexagon/lib/Makefile
> @@ -2,5 +2,5 @@
>  #
>  # Makefile for hexagon-specific library files.
>  #
> -obj-y =3D checksum.o io.o memcpy.o memset.o memcpy_likely_aligned.o \
> +obj-y =3D checksum.o memcpy.o memset.o memcpy_likely_aligned.o \
>           divsi3.o modsi3.o udivsi3.o  umodsi3.o
> diff --git a/arch/hexagon/lib/io.c b/arch/hexagon/lib/io.c
> deleted file mode 100644
> index 55f75392857b..000000000000
> --- a/arch/hexagon/lib/io.c
> +++ /dev/null
> @@ -1,82 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * I/O access functions for Hexagon
> - *
> - * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
> - */
> -
> -#include <asm/io.h>
> -
> -/*  These are all FIFO routines!  */
> -
> -/*
> - * __raw_readsw - read words a short at a time
> - * @addr:  source address
> - * @data:  data address
> - * @len: number of shorts to read
> - */
> -void __raw_readsw(const void __iomem *addr, void *data, int len)
> -{
> -       const volatile short int *src =3D (short int *) addr;
> -       short int *dst =3D (short int *) data;
> -
> -       if ((u32)data & 0x1)
> -               panic("unaligned pointer to readsw");
> -
> -       while (len-- > 0)
> -               *dst++ =3D *src;
> -
> -}
> -EXPORT_SYMBOL(__raw_readsw);
> -
> -/*
> - * __raw_writesw - read words a short at a time
> - * @addr:  source address
> - * @data:  data address
> - * @len: number of shorts to read
> - */
> -void __raw_writesw(void __iomem *addr, const void *data, int len)
> -{
> -       const short int *src =3D (short int *)data;
> -       volatile short int *dst =3D (short int *)addr;
> -
> -       if ((u32)data & 0x1)
> -               panic("unaligned pointer to writesw");
> -
> -       while (len-- > 0)
> -               *dst =3D *src++;
> -
> -
> -}
> -EXPORT_SYMBOL(__raw_writesw);
> -
> -/*  Pretty sure len is pre-adjusted for the length of the access already=
 */
> -void __raw_readsl(const void __iomem *addr, void *data, int len)
> -{
> -       const volatile long *src =3D (long *) addr;
> -       long *dst =3D (long *) data;
> -
> -       if ((u32)data & 0x3)
> -               panic("unaligned pointer to readsl");
> -
> -       while (len-- > 0)
> -               *dst++ =3D *src;
> -
> -
> -}
> -EXPORT_SYMBOL(__raw_readsl);
> -
> -void __raw_writesl(void __iomem *addr, const void *data, int len)
> -{
> -       const long *src =3D (long *)data;
> -       volatile long *dst =3D (long *)addr;
> -
> -       if ((u32)data & 0x3)
> -               panic("unaligned pointer to writesl");
> -
> -       while (len-- > 0)
> -               *dst =3D *src++;
> -
> -
> -}
> -EXPORT_SYMBOL(__raw_writesl);
> --
> 2.39.5

