Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367034C6C;
	Wed, 13 Nov 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507496; cv=fail; b=BRwJ33w8rkMbBjFVWQxRlhLFd+X8rM3c0FKUbHvVfkePG5ijM51JDE23Cc1j8KkCLbEy/SpLYcdahupvQtiGq6nbEY6uyKCPDD0JzlFzIjcwh0pq7XIYqFmmeJ8Z7HyowtOGlFRII96S5GsEue8sY/pNsu6RMFmqzk5eTushNgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507496; c=relaxed/simple;
	bh=0iU/X5iR4ITo10Ak27wAI8UEuvgDNneFhsB8eM5Edoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G17nNZDfahrgbosAl8hyrprAeuJzkQQkRGp0SU1HYgtq/F2wIG3SfIXgfUw2vV7dtAA3x8Hoz7ZBzhXHnu4qd2bM9tJFbm8PAMoFDJdDG8gTNqoXXAmzXPFF3X3nXL3NOHBaT9qhkPZIgWcvuPFwoVes2FF63qQGTem1c3rwj4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j8cTUe9J; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j8cTUe9J"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD7ut2b030545;
	Wed, 13 Nov 2024 14:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B3/Y3lxQpaCZvuC3IWr81jC6kQYhCOjDtTmgX3105AY=; b=j8cTUe9J+KnOr5jt
	jAqZrI+iDQs4bkBVhe1glUWKv9FsfWRLijinBJF42stYEI4ifyJkVcMt3ogKJ1jR
	gQeTGs8B/kp0aB4MYkemczRR0K61wKORWcY8ejTGP+DPgFVEmiUmg9obGhbkfGxh
	hJKPnc1n97m6B0XLaGvECC09sG4O8lXLeP9cHxAdsOYzPwDRmTlypntFp3OMZ5lb
	nxJXxUGWfj1A3rkJOLDoDfO/TOAUlVmVmfkmzOamCXQlGBh0rPOBsEnwtBSSp2yb
	1opp9nBX6AGU8MXUEwanF4eiUErxY/cQ0QsYok+cJImzc0ZnS0IeMQvsxjetug7J
	LZA4QA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vr5y0xcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:18:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtKxZbhIjuDT5+1BWDkOnouNDFo0osF6KR/y0987+/ao6ScoPF//BCKlWQBYmXGTqpH+WgGgT7naZTTOS8zMQ33BF43sPaFHVZjKSlaQuMype6EWoU01KeHhkYI8shrJXwszzQ2659o/pMWJ8LWgx+t+66XZ0Wt/qJFdGRMggiSbNjXLA8zfAEAI5Z2YXKpDTMHaqmgqrs6QgxvjQXJqnjWfj6DhhEdHu3X3Z0/dX/HSlDb1iT5BDrvpixH2W7ME+1PiwayrwPKVRtfcUv54XC7EbZFWbP2u63hEUMTTtepS89KftYbxjaZ+DicSpXthgD7Lt9CIS49nep1vqtDjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3/Y3lxQpaCZvuC3IWr81jC6kQYhCOjDtTmgX3105AY=;
 b=BIzwt4+zxE6rb0reLClIROSjD57lAbFgZcM2SqFh2dqV28YBdv5HSsFRSsfq0caMmYwrgzUiTESjMMqy2chJqowVdzWkb4kF+seBw9Xevxw71bZVLxiZ3pRm1XE44UVWEIP3EihkD9uYWxV/CWETqydx8SUkfJQHhQPjgDpk2UykfEi/mxedS33TPJhS7MKLnKQcPMEX6ConhtQp7sJCs+E8HQFztF5CmTTjch4TrkN769SYAOBadSt29L+LDkAMIxgPpU2q1wFfffJed/kMSfV45pBuIKuOC/+yshkwk3SWjZAgSlEHaST0P4i1gkT3s4cV3hXgD62lSdFUbb3gFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DS0PR02MB10250.namprd02.prod.outlook.com (2603:10b6:8:192::5)
 by BY5PR02MB6627.namprd02.prod.outlook.com (2603:10b6:a03:203::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:18:04 +0000
Received: from DS0PR02MB10250.namprd02.prod.outlook.com
 ([fe80::3df9:2304:93de:72ea]) by DS0PR02MB10250.namprd02.prod.outlook.com
 ([fe80::3df9:2304:93de:72ea%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 14:18:03 +0000
From: Brian Cain <bcain@quicinc.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Alexey Karyakin
	<akaryaki@quicinc.com>,
        Sid Manning <sidneym@quicinc.com>,
        Sundeep Kushwaha
	<sundeepk@quicinc.com>,
        Shankar Kalpathi Easwaran <seaswara@quicinc.com>
Subject: RE: allmodconfig link failure on -next (relocation R_HEX_B22_PCREL
 out of range)
Thread-Topic: allmodconfig link failure on -next (relocation R_HEX_B22_PCREL
 out of range)
Thread-Index: AQHbNYJkEqqIKaFdX0eC3yeaL8Dbd7K1QEgg
Date: Wed, 13 Nov 2024 14:18:03 +0000
Message-ID:
 <DS0PR02MB1025072B87B225A4A8F0953F5B85A2@DS0PR02MB10250.namprd02.prod.outlook.com>
References: <20241113041319.GA158543@thelio-3990X>
In-Reply-To: <20241113041319.GA158543@thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB10250:EE_|BY5PR02MB6627:EE_
x-ms-office365-filtering-correlation-id: fbc2147a-27dc-4496-0f3a-08dd03edfc6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GF029PVeslCCwlnztziF2sUkau+lccejz8SAU7ht/kMlDkNwA6HuX+SdDXYE?=
 =?us-ascii?Q?Qyn5DwEPBb/LYGDdTdoDbWV/i522q4ZdJn98iH/lH1YzdRcz9Hw6aTiYAfow?=
 =?us-ascii?Q?CwI8GgmiqEK1uLXE//rgRTOtcj7dqcn7EfHBbOs7xgjgKNToBuC/OvG7eZIt?=
 =?us-ascii?Q?n0WNtyPt2OeU5xLwjxUNGta4TlszSAGmoze8GT57qHFZM5kXyQPLVOUjrfdz?=
 =?us-ascii?Q?vQVlnOUw1PpzVvEl2MHQ6+zfYWv0sMA8/ZYjg+ugxSw+UOdgZdzxIGDBrUCR?=
 =?us-ascii?Q?0gqwojSA9zjLE/9slt1gdNnY/pXy7S/64GJAEvWVlot6NgwkdDO/gbpyEcoN?=
 =?us-ascii?Q?EDitMHGaRc9DC/xZXYcvDTG2av8/kYdyePVHFUMaYA5duC9aJrAIOaoueGzb?=
 =?us-ascii?Q?60ZYO0Sx7TXAga2G3x1yznNtw0tWICEO19YiF1Tf6Tv2yQlhhicofZt3gTm3?=
 =?us-ascii?Q?ylSrxNEe7hksttSTenk3aJfjujrnva6oGfT4ZFTPKVLzP/rziQRyfR4H0CxX?=
 =?us-ascii?Q?dvRiNkhE2b02ZSdHkZiHr5xxCzEpOkhIzW5DL0CM4oVrZbSi1MtAzehUWVFE?=
 =?us-ascii?Q?rEZkT5Rnkjntv+1VGrKdsdQXFYvRWpoSu2S1HCXLpXFeArpIA77wR+CSHYVN?=
 =?us-ascii?Q?2wxkow9186MFEOr8OwQA5NRaNGnLA2kU+Dopf4d0oh/yDTWtA7w4Y3J7GCjs?=
 =?us-ascii?Q?FcaUzuy3WFQY6Z719WBic7rsngoA4gjdfNsD7nXmb8ZFkVYCT+0y81phlRYb?=
 =?us-ascii?Q?prS4QEuHtfESnp6KQeIlRqfnxaR1e/uX/pVX84k9QiETyw0Zn26Bcy8z89fQ?=
 =?us-ascii?Q?32g+P0o8FyTIxhaS/zuPOWUtlFjOBFfmUe5a4wnHqts7XhHogzpo4hNg/xMy?=
 =?us-ascii?Q?8ISMr2pZcl3eE0JPBc+FmpdclIhwOzmA1BgljFniC8bZR/7QfIKKVlJxnfSF?=
 =?us-ascii?Q?xrCmfDyiRNMe/sfMyNKzMCXdsuEvxOzpsbgvxnJBBB/b/99AOZUM+LXuqAgH?=
 =?us-ascii?Q?718tCnGkaoFEM1Ya3stfy+rH3P/Vdtkg38waLUubo50mkmbo4eBSUWWz+BLA?=
 =?us-ascii?Q?8ol96u7O8qovn53s751s3DwYx7whQOr3zMQHM7XJo1gMIL+43bfpVFZre1s2?=
 =?us-ascii?Q?uiC06BVowjL0+67P78C9YZxCH9RgwFTxv8ftVrx1sRmTm76XgwbOyCE2+ek2?=
 =?us-ascii?Q?EgReviYjpNhY1WIRzqrD+ReTUvx4tqHL+Rxt4uTINAThbEQYNWzOyLRcxy37?=
 =?us-ascii?Q?A7yD0K6/4aElpyhjYMee9TyNGTDDiy3G2urveYSUCJqeG0QvfONc7tT0tqin?=
 =?us-ascii?Q?SZD44qqviSMon7D4RjFwZ5Tbi8WfDt56sAZVgY79rhET3eeyQdCm7J/DkjKf?=
 =?us-ascii?Q?p6TmjVXdSXCHnahZB9Tc0vxXJDEK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR02MB10250.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Nvs0GbV9LbQfL1TZd7j9SWg6dF5vEtpGrRJ3WdbWNUqECbQ830XPBxhy39Jg?=
 =?us-ascii?Q?fqcWmorLSHWcQ7xRjrseFYkSkLkiJeFHyJjGDXXMPlcemVUYA17VyKyAgohF?=
 =?us-ascii?Q?++HEr/3SK36oW34oxrqFxMZDbjZSd4+jpAWZ43sLFRXbSCXXvSYXFot6ljrG?=
 =?us-ascii?Q?OglTxKqrauQp8A9Tk6NxzFfFcLXiOpUyNqHsv2kye2iz5yeM4WzKaoxiS2ig?=
 =?us-ascii?Q?9TwqnpVKSt6/P7aIVLiXXPNPy5olG1zItrGGwY7UcwDtZcA9CNjbv7Ufm5Oa?=
 =?us-ascii?Q?w/GCki1O5AOMnXrzKWKqMpht8NGYjZiAs+w455QYDtYYyL7LvkW2luTVYlre?=
 =?us-ascii?Q?uxsODzAPgYiyFCAbPqj0cjBr3nakxRqQcOQAGgM5iwgJ0wiOhgybL6AaR2mH?=
 =?us-ascii?Q?FmcSpkxA+MEbywM0nJy5VYyVND+D3M7gfYgbU22IXntWEPcZAwSjWwI/inhw?=
 =?us-ascii?Q?qfxdvfIP5Cwo1oiOvBWV1F343/i+8uL9sFzauqyNwiVi1IO4r4cbQWqE8Ma/?=
 =?us-ascii?Q?R6G0J7BRgKorEUYuzERahK4rvsN5CGPuztFU29TqRJv4crJVHeeP+0yCJpav?=
 =?us-ascii?Q?custl/DJi7f2/4hBtgRkobc9GqlYPJ8jgvEmzxoU5wBhz4m3/oKLayr4ej+r?=
 =?us-ascii?Q?wlnZPuHmRju/G39IlbxkNONkB60hk8B2tcFucyaYnQ3XgI7Olv414kXb6e2A?=
 =?us-ascii?Q?yaJ2Lzx+DVk/1L0W4ICciH0gRskCoHfsXnLfUTygQW5jpGmMPSEslG/WrT3r?=
 =?us-ascii?Q?RFAkbOuY9T8Zd3LyUA5K3rAYjiJqS4hzQZIYWcN3nYAHHS8RYsoqt70Rk/ta?=
 =?us-ascii?Q?J68cwfvgGspy0ggi2de6ye8Jug8WIXz8M3aViZmlq20CIo/8o2DVXMjT3BKN?=
 =?us-ascii?Q?miEaFuIG8/5IgQ6bt46ddcXb9jkFRq4aCx/33+WyK4drzU86UYZSoVBMztkU?=
 =?us-ascii?Q?0y/HTMASuXcxib93J8QaM/vhckQS2IpyjbPs3b58DF7Q2J5BrrWu3YY7vO5g?=
 =?us-ascii?Q?l9zXRlXyJDXk8TR8vfiHut8FV3lYdpId0l2Xc9hKh1c6XE81QaD6EAxqNPHR?=
 =?us-ascii?Q?M2qaAq4vHT4N71k0Je3celVG0DS4GNZx1GxlsLKcremo2VXWrmBA88V7Kgx9?=
 =?us-ascii?Q?qH0zpiAtEZZDdaN+zc9Sx9LBwnCYTGOfNEVtZJpR73vZ1gsgMIvek8Ou6i9M?=
 =?us-ascii?Q?UZVzWIOYT5pLAanPZ/m+ajdttoCrwAhIVyggK1+UMFM3VJsegXUMyCUx/+h3?=
 =?us-ascii?Q?bfPG4AsQMaClTeGylKXsQrRGzKVMVKhAOukDijiyb8kr+09oKBS8HR4SYjFL?=
 =?us-ascii?Q?VqL9/04eNWQgT8nHRvtsJz+RHqYWll5uUPXqVnAhZkhZ2PHuLDtcKfFW763c?=
 =?us-ascii?Q?0lg6M7ElX0vkL74jmToDcWzKPVsCbMRYKc9cmPmTWRiaQfdhvWrhpRLEXJTF?=
 =?us-ascii?Q?Q6bFo2BRUZ6gWWoc+v9OlngoRGL9aWGOD3iOlsvlze0cGZ6p3obFWZZTE+N5?=
 =?us-ascii?Q?kzfi2iTP/ABqyWHnoTGKjnc65Qv7u8sVGkodLvvyWIhdMDAMKFrYz0X1Tp0u?=
 =?us-ascii?Q?Ynflxgcy7XKkkAtfkec=3D?=
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
	Ob8P/UDAPWqFyU2DMep67Ywl4OhB1O83ymRgHH3B5rJaGVOehwP/GXPPNh/K2dqhPqcNlotPBISyh4Z2/3t9uTyuAsutJLVqVMULo9dpwNqbnQXx59GQEJx32QP1zUoy6CVz5DMCc8CQST7tFZLRPvYvqc7LaDBK16drwHSUboB3BNG1vfJvJXZDPmbxRLyT6JEu/oxYvcjf/ubPmVWhYyth+7pnQ9p0iI2zWdXVivVPZ3jiQJFhFqwE4gYyjL/LRxENekxZs28VNGnYoVMyTXtzZkxCW34nYTiJPXMVZQeECrJqynlf5CuENIk2jQ412CSATfH+jGrFcTPkADCza8jzPspVnk5aynXX/7t/7KJm9YXwqPKaKoYNhp9jXP7OQTVBLcXJN/atQzSNosTKIMNR4NP0eeutFvv5+tht/j5eG384DydvDb20xYGoRdvTOwYV4qJf0GQm5NwCspbqj1EIxhNuNlziJlF38y1hRnDVyRUDOQOyqYAoW5Jzp6PqsPJbjI/uZHnU/TGTvNnCFwKFT5y7FRWvesuT6142P1IzC83pFfZFW8ZOAFQyHYVcvm5x5UeQpJl9ZBl4lUouE8i2tnnNJrXcE9ZF8tYJgcd6OGnu5yIZyXJHlCGEFlsa
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB10250.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc2147a-27dc-4496-0f3a-08dd03edfc6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 14:18:03.3056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwJjKT0PlfP2FXGKg4txp+w0u6zOOZEV9Ul9XxccM2qb0TLVQB0xk3G4W9mJLGem+xoCdhcb164yZ6pI6Y8/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6627
X-Proofpoint-ORIG-GUID: ZLVh7e6c7Nbhp_WbUWFWly6nepomUWZH
X-Proofpoint-GUID: ZLVh7e6c7Nbhp_WbUWFWly6nepomUWZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130122

> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: Tuesday, November 12, 2024 10:13 PM
> To: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org; llvm@lists.linux.dev
> Subject: allmodconfig link failure on -next (relocation R_HEX_B22_PCREL o=
ut of
> range)
>=20
>=20
> Hi Brian,
>=20
> With next-20241112 (and some prior versions) and tip of tree LLVM, I am
> seeing a link failure, possibly because the kernel image has gotten too
> large? A simple reproducer (KCONFIG_ALLCONFIG is needed to workaround
> other tangential warnings/issues):
>=20
>   $ make -skj"$(nproc)" \
>          ARCH=3Dhexagon \
>          KCONFIG_ALLCONFIG=3D<(printf 'CONFIG_%s=3Dn\n' {DRM_,WERROR}
> GPIB_NI_PCI_ISA) \
>          LLVM=3D1 \
>          mrproper allmodconfig vmlinux
>   ...
>   ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x160)=
:
> relocation R_HEX_B22_PCREL out of range: 2098032 is not in [-2097152,
> 2097151]; references 'memset'
>   >>> defined in vmlinux.a(arch/hexagon/lib/memset.o)

This error seems to be due to an incorrect range calculation for this and o=
ther relocations.  Alexey has a PR for lld under review https://github.com/=
llvm/llvm-project/pull/115925

In addition, since our initial hexagon port landed, lld has added support f=
or range thunks.  And Alexey and I have a PR for that too https://github.co=
m/llvm/llvm-project/pull/111217 - this should make us generally more robust=
 in the case of larger executable images.

> I did notice that this error was not reproducible with LLVM 19 so I did
> a bisect of LLVM and it seems like commit 6b11573b8c5e ("Recommit
> "[FunctionAttrs] deduce attr `cold` on functions if all CG paths call a
> `cold` function"") in main introduces this, so maybe it is that
> .text.unlikely grows enough to make .init.text be too far away from
> memset() in .text?

Yes, that seems to be an accurate analysis.

> As an aside, do you folks working on Hexagon do any sort of validation
> of the kernel and toolchain? I feel like I have run into a decent number
> of Hexagon-specific issues this year and I am curious if any of these
> things have been caught by any testing that you might be doing.

We don't do enough testing of the toolchain changes with regard to the kern=
el.  I think we have room to improve there.  I'd like to incorporate more t=
esting into our workflow for landing changes in upstream LLVM.

-Brian
