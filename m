Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9B83BB24;
	Mon, 30 Sep 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714125; cv=fail; b=pN87c7NFi4laYLjHyjetyq6Yk+goQiyJ6CtYRnTYbGT2uIunaFv1flTdwKFX/enkeRSmXjB+6tJsLPbMDyEQFeXVNed6l2YuW/vXj0OnxmjpNxiAWKgU2IAim7qC0ujoYCu7dtXxNkEtj7sKhNBJxwYDxa/AVLDd3X776tDqyag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714125; c=relaxed/simple;
	bh=/fNfqEKR1guL5c8QWWOQ8b7HaHN6KuKCvoNYHkjSLcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ov/zUEjrGvwhpJCgeyJgw8Dm1qZ8nBLTpEtCWehv23wGryKaQ5aK0oHCVJvoqFF4lCuspc+W/GxbN8F8d19CkLLTh4WD4fSc2j50NMqzKmZkXEwJ/SxBpckDmgqkhnf6q6nNwRZL9p7acYi0zTiX1GFnK8dzexm1zd3x0gwNfpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KHzLNByv; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KHzLNByv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBLX5k018007;
	Mon, 30 Sep 2024 16:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/fNfqEKR1guL5c8QWWOQ8b7HaHN6KuKCvoNYHkjSLcE=; b=KHzLNByvOav58ib+
	Op39iMJG0ccXB1MINgi0Yz8kJpTUHQVnO5tE9a5uuv98ZojY/6c0htq6Lok3WOU+
	pDfWvze92YZmarHVR01MHuV2eAAMwZE4eE9utvRHPgkUHRnkBXH/uy97yOIn2KnG
	8YTloPAlqPoZv/GkjhdqKW2h5QBr2RDWyc2HjQfaR5Jpmd30NKxrrRGq/xkiuUcA
	49XuoXsIwPG+AmL7evmY08/eKuiBXFETW8T2ob5jCbkRwi3PiG61f7Hg/KQJ6uWQ
	IPH8IoS/u/ZoiGX8YQPM8GUt+AgDfuDNQ5YJauIxA3DZzAQFu7ftYZ3hFXoyZdN/
	JY1BgA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x7ge5m7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:35:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnO4AOKABTnmTqts3LnohBAotXB5QPE8B6ow3pZd6PU+BEF2Hfnnlj0QL0Zn62wAEOvsdytkkKWo36ygo+wGZJH2VslK82TA76z5w7J2MUvhFLVnB1+aAclopJnpBdlr7Ho62Fa2iIw+nth7/9yPAEowT5l3OLUTmoE696Rl/dzBYYBvEEcChnYm0FGSJcMhRIOP5Fce4+n8OzmmJnc3jcFYOkJc4amfGsc2zNDyvwFB0cq1YLb8Pu8P3PXu/BOeEsCfkbeGyHWYPwMn+plFAVAWOXk866tuQxIizxLngiIlavZKXhGC8fQem40mG+vxaQbepp5wXbWiLweho0HwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fNfqEKR1guL5c8QWWOQ8b7HaHN6KuKCvoNYHkjSLcE=;
 b=YQJGySwMj5dokUrTRFx8GS37eShjdpHnzFXy7nAT9cygNHT3AICfF7+e+XzTxOLPruP1PFXu23HyZsaxUNtp7gi6pH9kQf3DlUkEnGmrPCxKSaz0HL/NSp1aQ7/N3Xj+ryr+OEgKK+ObV+Nk0ePMESz87uBbC1UY6e0GDIbs0G8Jjw/HiZD13cBYqxkeVDzGNJ7kmmdaIvuA34gQMhcvbXxv1F4KNHVtR3FYyaMO6893L0AeH0DH2n1cLX3Mf7wvvg5iLL/adqTBzErHJxpFq6P1CcXTsO15RMjOeQqSFvftVnxOt2xQSEV7lMhYVr3W5/Lnroaq+WjP8PFUZuBsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by CH2PR02MB7030.namprd02.prod.outlook.com
 (2603:10b6:610:87::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 16:35:16 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11%4]) with mapi id 15.20.8005.026; Mon, 30 Sep 2024
 16:35:15 +0000
From: Brian Cain <bcain@quicinc.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
CC: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Arnd
 Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without
 HAS_IOPORT support
Thread-Topic: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without
 HAS_IOPORT support
Thread-Index: AQHahcpVFLymayp/+ESCyghLOHlzDbFWoRoggAAItICAAAGzYIEa6e4AgAAMREA=
Date: Mon, 30 Sep 2024 16:35:15 +0000
Message-ID:
 <CH3PR02MB1024732DF7A1A1FF81535A7D0B8762@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240403132447.719833-1-schnelle@linux.ibm.com>
	 <20240403132447.719833-2-schnelle@linux.ibm.com>
	 <CH3PR02MB10247296630FC062F4E3DE2FDB83D2@CH3PR02MB10247.namprd02.prod.outlook.com>
	 <c04ed601dbd0a8053e034fef1c05ce2ca6e95392.camel@linux.ibm.com>
	 <CH3PR02MB10247A45A17F7D8104D1922A8B83D2@CH3PR02MB10247.namprd02.prod.outlook.com>
 <6c8daef875f9981c59fc5ce9c81eb8c3c2618b5c.camel@linux.ibm.com>
In-Reply-To: <6c8daef875f9981c59fc5ce9c81eb8c3c2618b5c.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|CH2PR02MB7030:EE_
x-ms-office365-filtering-correlation-id: 2b872788-eecb-4b7c-1080-08dce16ddcba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SldCS0VQRDBhMk9GZXloUWxWcDk1anVKK3J0ZDBNcDFOYWthTjJjZTY4OTV0?=
 =?utf-8?B?ekVHTEE0WTNGVG1DbXFaRkVyRlRFNlp2bkVFODBRQzBRVWdrcy84VGdSOVVP?=
 =?utf-8?B?MmFhVExFRXkzbDN6UnBER0FBOFNBWnB4Y3UwUmdleUl0ODNyZjFyTXh0eFk0?=
 =?utf-8?B?N3pNb0d1UzU1VGFQZUtWaGtSN3F0QWlSR1FyT0YwK3haNGo3eDdVZXo2T255?=
 =?utf-8?B?VkNQZXl6TjBFeFE2Q28rUXQ1dkI3MHBPSXh2eE5OU1ZyZTdFOTN3cUp3bjI0?=
 =?utf-8?B?T1E4bHFOZVd1d243bVNYYi85ci9FTXhOc1RjUDV2Qzh2SzdVbHk3bDdyeGt3?=
 =?utf-8?B?NG5Fa0NYMnoxVllwQmhKYjBhenBWdDZhUzFIZjk1Y09nZWJkUkN6d3hLYUts?=
 =?utf-8?B?cElyQWZTM1ppQU8wMzJuZzlnUmUwNU45bnJOdmdIaFJyWGx1eUJkbEJQV1kv?=
 =?utf-8?B?MEc1SmtuNjlJUGpoNGVxSFEza2djSGtVMGs5bUsycGNaMm1tZkJ0OGczVVo1?=
 =?utf-8?B?UHpPVThWQjFMT2ZzZXNrMVdSc280SDVpNHNVRjZKemp5Z2k3NUlEdlNUUUpa?=
 =?utf-8?B?U2xHYWRpdU5pNTdNY1ZUZ3MvT3ZEcmNQQkhUSnk0anlqY3BoemZVU2FGVjRT?=
 =?utf-8?B?amQ1eUZIM1RKYmxwd1JBZFU5QzdSaGdISmdVMXd1UXB1RXgvTnhIT3NkOUJC?=
 =?utf-8?B?M2hlbFEzb2ZrMEllU3kwbEZ3dGhLUzc5ajQ0cFRUOFhXZVplYXhUNm1Da0lj?=
 =?utf-8?B?SmpKYmZVUzBDNDJkZjloTWk5S3NGVHVFT1JURXV1NlZ2aWFxbWhSaWk4YnJJ?=
 =?utf-8?B?cEFQaExzbGd2RGtuMHNUdTR5S25LcHp1cVhvWG1Kb1ZBaWZhU3J4V3dCRita?=
 =?utf-8?B?c09TdWlmQUJsKy9uQmtvWlQ4WExDcXJDejk4eWQvUCtHSmRzbXVCQkJtc1hr?=
 =?utf-8?B?VkdnVkRERW1EbHk4a0Mzcm9BcVJnZGVxNDVKcGpQaFQ3dURIaDVhalkrSjB3?=
 =?utf-8?B?MWIzNCt0aUVzbVJaVHhxN0xOc3ZwbENpcGFNMzdrY21DQ21oYzdVMk5WdmFJ?=
 =?utf-8?B?U0EyOFRsOGJDWDliSWJyWmZoY0hLaVJQbU0vdUpESFMzTTg5SnB0MW9TeW9a?=
 =?utf-8?B?VHFBclhBTVRKM2ZWaWlLWHhiOHAzcGFKSDlwUnBzSHJsMlpHbEVrczJQcDNR?=
 =?utf-8?B?WXV6YVd2U0l0c1JyY3RYa0ZwOEtvUHlsZFhTMnBjZ3FqM3VOWFhWNFd0RVRO?=
 =?utf-8?B?UkdCbXdVaEwrcXlPczNjV1VrSzZiMUw0ak0rRVFmc0NsUlYxVmdtL2pEQU90?=
 =?utf-8?B?U1lySzVaQlc2SVVoaFd3TzJsM2gxanJHZERPajg1NzF2WVI3T3RycEZYajBR?=
 =?utf-8?B?Y3pYMkVHaitVWDczRm9XTnRROFNTcHF5eWJVc05PUkx2RjVOOWRyRnllSXN4?=
 =?utf-8?B?eWFnck1uQjVzUjhoV3JCTEFKWXdhYnA1dXRsb21iNk9BV2VNRDRUbkV5KzJN?=
 =?utf-8?B?ZU5lTEJpdFdOU2l2aGRjbGhNTTJUNWtROVlDaEN0emlLUUNNY3RLcVIzdHNO?=
 =?utf-8?B?MUZCNEhLUnV3bnpnMmQ4c3RJS3RUZUlwRG9Xd0hWYXpMYkZGWEdjQitYb0lK?=
 =?utf-8?B?aHZsakVTeUk3V0xKWC9xRXBjTXhta1daVmlURTR5SmsxVWZLcFl3RysybGls?=
 =?utf-8?B?TkJaODVsNDRaTXoyMVFVblRmUkY3aVBXNFZHNEpqbUhIVjZRbXVoZHp0SDJt?=
 =?utf-8?B?VnQwSEl2ZndDV2Q0K0JtUjluVU1nMlNwSmJNRXByc3hFa0F6ZHpNK3NDa1pG?=
 =?utf-8?B?NHM5VWoyOFlFQTR6S3FZK1lWVUp2amNqSnMvSUw5M2pPTk52UGJjcjNvZDVh?=
 =?utf-8?B?V0dVKy92N3VvQzJUZEJNN0k4ZUdyZWJZZVNQVEVOTTdXSXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR02MB10247.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkNDelJVV0VFbENDMUl5dXF5OEdjNkplNGVac3htQWlpczRHRlVQVjVSN3JG?=
 =?utf-8?B?eVg2dGF6b0lIUzNlVXQxMlptQzBKRmxSQ3ArNDBHczQ4Mk8zcGRuUjFQcEtH?=
 =?utf-8?B?eno5czE2RWNsYjlNTU56dko1UzBkYmVwdDVTVzgvTlcwZGo2Q0dIczQwcFBl?=
 =?utf-8?B?M1Q3ZXE1K2NQUTFubGlHcXhKdjY1MjlFOE1IemtDZkpYanNuMm9EclVjWWtB?=
 =?utf-8?B?Mjdkc0lmUHNyVm00aHBWQTUzczkvYXc2OTIrcnlDRXVDQVh1ZFhQYm9BTXhO?=
 =?utf-8?B?T2U4dlJXYjJsSW5YaGFoeFZKL2E3ZnlWS0RKUjc1MU1tNGFSMlpVQ0c5S3BK?=
 =?utf-8?B?Y2RpZnhzOWxCTlFXdmo2S0lqVFl1V2Y2YWVHMWdURzd4TUt0QVNaL1Bhbm9z?=
 =?utf-8?B?SEN0OVUweDh6YXBZUDFUUzkzaTBSR0VEKzJCdDZzSyt3S2hzalRjV0llLzNw?=
 =?utf-8?B?cm9jV0EwTmlCVG1Wd1FNOUI3cWgyaE05c2VHc0RCcnMvbVB1RWJRUHNMRnJu?=
 =?utf-8?B?M1ZNU090eUo3dXJSSE9CemMyTVFMdzFpQmZFRVZ5Qm13bjJwMkVKOFdoSHJ6?=
 =?utf-8?B?MnZudzBybEFUYVZpVWJUZENKbEpvUGlHdzU1YW5yVzR0dnZtZmZ0YS9QeGo0?=
 =?utf-8?B?NVcyYkV3cEY0S2VGc0FnSHpXalo4S2hxZ0IzNWs4QkpxMFRIYWo3M2dTUXFY?=
 =?utf-8?B?WHBMSG9wZDI4c2lVVXRONFY1d0dwVU1QTVlkbHAvQ0VISEN4S0p1cmxrN0dQ?=
 =?utf-8?B?d2xQNExFTCtnOFM2aGxUTjRaT252b0tsOHJyblB3ZlR6UDNranMrb2pIcURM?=
 =?utf-8?B?dlBudkhRMkNpeVBYYjJaTU1adFNSNE5SaG03cDNaY1FxUTVMT3dURGRjTVMx?=
 =?utf-8?B?bnhYOFpnUnRnK0tVbEpSTFRtMEROd0xwRVdFRHptRDJtNTJXSXMwMnF5YVI1?=
 =?utf-8?B?OXB6UUgxR3BWTWtDYkdqNmNldVZ3OVZwVFdqQ0pnaUx6YSs5QTI4d0VxN2hq?=
 =?utf-8?B?dVR1S2N3ZkdQUG8zRkRKN2NtRG5MQldGSVl0cmlrRVFobWtqK01CaStJdFd4?=
 =?utf-8?B?SlhCOHk4WU9RUmVWMFFadnNJR2prSU1ndUZ6KzhaZi9Odm41elNUaWJTeU4v?=
 =?utf-8?B?UEdKYmdaZFUveUVpeWJMZmdVZk5ZdURZN2taZ2pzNUNnZ2c2RlNBdUdqSC9h?=
 =?utf-8?B?YUhaNGc3NncySnN6V1Y3S0p5NW9JTFhBNjZOM2dEa05WYUl4eHNFRmtGS29t?=
 =?utf-8?B?dW1EYSt1dERTYXBMZWtPNDZwQmJHcnJQMFN6TkYwdm03cnE2UUpYRWRhcVV3?=
 =?utf-8?B?Z2JmUzNkZ3gxeURHOVlJL3RxUmdZR3JLYTBQUHdkb2l1Q0NjQU1qUFBScldY?=
 =?utf-8?B?WUhFYUJlUW00QzJqVEJtaWhhZXB1Sm1lUngvV2VwaU1oR3ZkSzhxNmVDdkZn?=
 =?utf-8?B?VkVRTlZIcmlKVGJKVWhqc1JPVVB6NkxzMXNMbkVoell5c09rNjV6TDdLeGNn?=
 =?utf-8?B?NUVtTFhJd1lCSENleGlTL05TbVRyWmRoV2JUNWxlSHRyVVVkMmd6ME1PWmQw?=
 =?utf-8?B?MGE4ZnpBbEZZR1REWEIxZ09IMjNVL0pid083cXR5clJicHNyUWVOWGRLMXNO?=
 =?utf-8?B?U0ZXSG81N3BZT0tVakpwK1NvTVhTakNDZTcxUGFzamljRXoyQWt3NldpLytw?=
 =?utf-8?B?M3g2WnpJYVV1Rm5XdkFxeFVDemNZVHVNazBTaERnV1BNVHlGR1BuSVJKT3R3?=
 =?utf-8?B?TXpjell6S2t6OGNKMHl2TVo5Sk1LaW5pN3hvM1VqbXp1MW5ieHprQmdCT2Rs?=
 =?utf-8?B?WFhDYTJxeVMwallONFY4Smd6MFpVdzFPUnhhSjJCK01lN1dHUHFjQjJLVFJU?=
 =?utf-8?B?Q0p6cVluTEh0QTNkSHJ1a2JnQ3UxOVpKNkpmR1pLYjlBUmVMS2o1ZVJFZjNo?=
 =?utf-8?B?V3drVElrcDFZRkd5RUFuZDdDZmN1ZWlRdkJ2YkdZQkJUVEVSeEJHUDdPTVZ0?=
 =?utf-8?B?REIyRXNubnRlVVROVHdCUzkyWld6OFo0dlc5NmdXVk1qeU03OG8wVmhQTnk4?=
 =?utf-8?B?Vy9GRFprTVFIanF0OHgvVzZaZVVaTVVVTXFzRDlQbHlHOFpjaXp2ZVBnTldR?=
 =?utf-8?Q?GX4Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0sl6CYoXroOJniwJK5e+fE1mZ4F8Ce492sC+ZBYnS++oS8bpR7KBHTHAC6ou4NzXwYi0th+vV4845Nf30o3/ZQBt56eNUWhZ2EAb9tOWKKcrc0+Wb/ztNsuv80IhOre1jCC+nZKQzT+hrQOhfjtfh6xPddf2TdLfhGwbPs7dxGgspWRMf5lWjhsRfWEouBGo8egQyndsVvyi7DU3W78r4R1aU4CRiQrQ9tFlZE4Pw/cvtCDKKD+Ny6Of2qcyJbc/PNYXJw0WZcYhBPE0uWekWPGPMkpSwkUnCj7SShfOyQoXxIgIPPmcTZWEN9VcNqkXjOeErmFHzrKyzRaZWSKBBBZ2NGzylfDnOl2bFEyhPm4DjR5ulUxQCoDu6igw9q79W1SeRcKz1uDAHy3cdfB/2/ykFH9WNmBogwwpnASVVBHcw6cBPwC8T1I9Ek4L9vud4tkJCL2whZpjNZ5NMANEPc1o8XdGT3InMPlQml3DC3nYicdw0VyMTPZr2PCljxmC4ks0BQF3qGs2xBACzEtQQqy94YKihfirxfOQXp55AtnlISn7tmj29PH6hYtCbuUF9qk7LpCKLlXochLoyWQc1t2yZDCTOBZKikd3YdYiROlXfGYjwQw8KukNqyQ/tbdN
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b872788-eecb-4b7c-1080-08dce16ddcba
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 16:35:15.0611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Knedy+KshjvbOH9DV/X93dcYxwbqXDw3RChdDl/Y7DiENlCgE1qtcB+wOWFivMiPEilNca/bN3qEnIq63pVHsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7030
X-Proofpoint-ORIG-GUID: 5CKeKV_ux_XBCOO1v2SSng44nN-GEwd5
X-Proofpoint-GUID: 5CKeKV_ux_XBCOO1v2SSng44nN-GEwd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=549 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300119

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmlrbGFzIFNjaG5lbGxl
IDxzY2huZWxsZUBsaW51eC5pYm0uY29tPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAzMCwg
MjAyNCAxMDo1MSBBTQ0KPiBUbzogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IENj
OiBsaW51eC1oZXhhZ29uQHZnZXIua2VybmVsLm9yZzsgQXJuZCBCZXJnbWFubiA8YXJuZEBrZXJu
ZWwub3JnPjsgSGVpa28NCj4gQ2Fyc3RlbnMgPGhjYUBsaW51eC5pYm0uY29tPjsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gaGV4YWdvbjog
RG9uJ3Qgc2VsZWN0IEdFTkVSSUNfSU9NQVAgd2l0aG91dA0KPiBIQVNfSU9QT1JUIHN1cHBvcnQN
Cj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVh
bGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mDQo+IGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5k
IGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiANCj4gT24gV2VkLCAyMDI0LTA0LTAzIGF0IDE1OjM3
ICswMDAwLCBCcmlhbiBDYWluIHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogTmlrbGFzIFNjaG5lbGxlIDxzY2huZWxsZUBsaW51eC5pYm0u
Y29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAzLCAyMDI0IDEwOjIyIEFNDQo+ID4g
PiBUbzogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+ID4gPiBDYzogbGludXgtaGV4
YWdvbkB2Z2VyLmtlcm5lbC5vcmc7IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz47DQo+
ID4gPiBIZWlrbyBDYXJzdGVucyA8aGNhQGxpbnV4LmlibS5jb20+OyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gaGV4YWdvbjogRG9u
J3Qgc2VsZWN0IEdFTkVSSUNfSU9NQVAgd2l0aG91dA0KPiA+ID4gSEFTX0lPUE9SVCBzdXBwb3J0
DQo+ID4gPg0KPiA+ID4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lk
ZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkNCj4gPiA+IG9mIGFueSBsaW5rcyBvciBhdHRh
Y2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiA+ID4NCj4gPiA+IE9uIFdlZCwg
MjAyNC0wNC0wMyBhdCAxNDo1MSArMDAwMCwgQnJpYW4gQ2FpbiB3cm90ZToNCj4gPiA+ID4NCj4g
PiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IE5pa2xh
cyBTY2huZWxsZSA8c2NobmVsbGVAbGludXguaWJtLmNvbT4NCj4gPiA+ID4gPiBTZW50OiBXZWRu
ZXNkYXksIEFwcmlsIDMsIDIwMjQgODoyNSBBTQ0KPiA+ID4gPiA+IFRvOiBCcmlhbiBDYWluIDxi
Y2FpbkBxdWljaW5jLmNvbT4NCj4gPiA+ID4gPiBDYzogbGludXgtaGV4YWdvbkB2Z2VyLmtlcm5l
bC5vcmc7IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz47DQo+ID4gPiA+ID4gSGVpa28g
Q2Fyc3RlbnMgPGhjYUBsaW51eC5pYm0uY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gPiA+IE5pa2xhcw0KPiA+ID4gPiA+IFNjaG5lbGxlIDxzY2huZWxsZUBsaW51eC5pYm0u
Y29tPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSCAxLzFdIGhleGFnb246IERvbid0IHNlbGVj
dCBHRU5FUklDX0lPTUFQIHdpdGhvdXQNCj4gPiA+ID4gPiBIQVNfSU9QT1JUIHN1cHBvcnQNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91
dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZQ0KPiA+ID4gd2FyeQ0KPiA+ID4gPiA+IG9mIGFu
eSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gSW4gYSBmdXR1cmUgcGF0Y2ggSEFTX0lPUE9SVD1uIHdpbGwgZGlzYWJs
ZSBpbmIoKS9vdXRiKCkgYW5kIGZyaWVuZHMgYXQNCj4gPiA+ID4gPiBjb21waWxlIHRpbWUuIEFz
IGhleGFnb24gZG9lcyBub3Qgc3VwcG9ydCBJL08gcG9ydCBhY2Nlc3MgaXQgYWxzbw0KPiA+ID4g
PiA+IHRoZSBHRU5FUklDX0lPTUFQIG1lY2hhbmlzbSBvZiBkeW5hbWljYWxseSBjaG9vc2luZyBi
ZXR3ZWVuIEkvTw0KPiA+ID4gcG9ydA0KPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+IE1NSU8gYWNj
ZXNzIGRvZXNuJ3Qgd29yayBzbyBkb24ndCBzZWxlY3QgaXQuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBDby1kZXZlbG9wZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz4NCj4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+DQo+ID4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogTmlrbGFzIFNjaG5lbGxlIDxzY2huZWxsZUBsaW51eC5pYm0u
Y29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBhcmNoL2hleGFnb24vS2NvbmZpZyB8IDEg
LQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvaGV4YWdvbi9LY29uZmlnIGIvYXJjaC9oZXhhZ29u
L0tjb25maWcNCj4gPiA+ID4gPiBpbmRleCBlMjMzYjVlZmEyNzYuLjVlYTFiZjRiN2Q0ZiAxMDA2
NDQNCj4gPiA+ID4gPiAtLS0gYS9hcmNoL2hleGFnb24vS2NvbmZpZw0KPiA+ID4gPiA+ICsrKyBi
L2FyY2gvaGV4YWdvbi9LY29uZmlnDQo+ID4gPiA+ID4gQEAgLTMxLDcgKzMxLDYgQEAgY29uZmln
IEhFWEFHT04NCj4gPiA+ID4gPiAgICAgICAgIHNlbGVjdCBIQVZFX0FSQ0hfVFJBQ0VIT09LDQo+
ID4gPiA+ID4gICAgICAgICBzZWxlY3QgTkVFRF9TR19ETUFfTEVOR1RIDQo+ID4gPiA+ID4gICAg
ICAgICBzZWxlY3QgTk9fSU9QT1JUX01BUA0KPiA+ID4gPiA+IC0gICAgICAgc2VsZWN0IEdFTkVS
SUNfSU9NQVANCj4gPiA+ID4gPiAgICAgICAgIHNlbGVjdCBHRU5FUklDX0lPUkVNQVANCj4gPiA+
ID4gPiAgICAgICAgIHNlbGVjdCBHRU5FUklDX1NNUF9JRExFX1RIUkVBRA0KPiA+ID4gPiA+ICAg
ICAgICAgc2VsZWN0IFNUQUNLVFJBQ0VfU1VQUE9SVA0KPiA+ID4gPg0KPiA+ID4gPiBSZXZpZXdl
ZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+ID4gPiA+DQo+ID4gPg0KPiA+
ID4gVGhhbmtzIGZvciB0aGUgUi1iLCB3aGljaCB0cmVlIHNob3VsZCB0YWtlIHRoaXM/IElmIHlv
dSBoYXZlIG90aGVyDQo+ID4gPiBoZXhhZ29uIGNoYW5nZXMgZm9yIHY2LjEwIEkgdGhpbmsgaXQg
d291bGQgYmUgZWFzaWVzdCB0byB0YWtlIHRoaXMNCj4gPiA+IHRvZ2V0aGVyIHdpdGggdGhvc2Uu
IEFzIG1lbnRpb25lZCBpbiB0aGUgY292ZXIgbGV0dGVyIHRoZSBwZXItc3Vic3lzdGVtDQo+ID4N
Cj4gPiBJIGRvbid0IGhhdmUgb3RoZXIgY2hhbmdlcyBwbGFubmVkIGZvciB2Ni4xMCBidXQgSSdt
IGhhcHB5IHRvIHRha2UgdGhlDQo+IGNoYW5nZSBpbiBteSB0cmVlLg0KPiA+DQo+ID4gPiBjaGFu
Z2VzIGFyZSBhbGwgaW5kZXBlbmRlbnQgdW50aWwgSEFTX0lPUE9SVD1uIGFjdHVhbGx5IGRpc2Fi
bGVzDQo+ID4gPiBpbmIoKS9vdXRiKCkgd2hpY2ggQXJuZCB3aWxsIHRha2Ugb25jZSBhbGwgdGhl
IHN1YnN5c3RlbXMgYXJlIGNvdmVyZWQuDQo+ID4gPg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4gTmlr
bGFzDQo+IA0KPiBIaSBCcmlhbiwNCj4gDQo+IFdpdGggMiBtb3JlIG9mIG15IEhBU19JT1BPUlQg
cGF0Y2hlcyBoYXZpbmcgZ29uZSBpbnRvIHY2LjEyLXJjMSBJIGp1c3QNCj4gbm90aWNlZCB0aGF0
IHRoaXMgb25lIHNlZW1zIHRvIGhhdmUgZmFsbGVuIGludG8gdGhlIGNyYWNrcy4gVGhpcyBpcw0K
PiBwcm9iYWJseSBteSBmYXVsdCBmb3Igbm90IHByb3Blcmx5IGNvbmZpcm1pbmcgdGhhdCBJJ2Qg
YmUgaGFwcHkgZm9yIHlvdQ0KPiB0byB0YWtlIGl0LiBEbyB5b3Ugd2FudCBtZSB0byByZXNlbmQg
YSBuZXcgdmVyc2lvbiByZWJhc2VkIG9uIHY2LjEyLQ0KPiByYzE/DQoNCk9oLCBzb3JyeSEgIFll
cywgaWYgeW91IGNvdWxkIHJlc2VuZCBhIHJlYmFzZWQgb25lIEknbGwgbWFrZSBzdXJlIEkgYW0g
YWJsZSB0byBsYW5kIGl0Lg0KDQotQnJpYW4NCg==
