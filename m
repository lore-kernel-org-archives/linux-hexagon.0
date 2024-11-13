Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76B20125C;
	Wed, 13 Nov 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522865; cv=fail; b=frWcYdqaCWGAE+4F998T6RHPcrX/bn6fgGpAtUGJQdTFwwvXj7T+rs5HAralEbIVGJJ8DEQfaVThgIr0a4H8V8da1lkOvK49+VcjVG2zHZ/1To0AQBvgPYqocQfMv5OVs67cKJOYYJVdaQqc01ddEfFPUtVaTy7iWe4dwxsCM70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522865; c=relaxed/simple;
	bh=4YrHrT/dGX1NoXKCuLD8L+KWlPZUtO25rarwE+74NtA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rsU4cu7BFrJPs1yOiYdQYGcqX8yhtJTzG0Q7AdmEk9N+Y24suSKlcV/e5SZ8JmrEw9WRgUtoSwlPHx3vRftXGs7UN+C82hXjlXlLNp224hdeuI95ju/Rf8hnirHWw+a1imv2Y4BiiCM4TtbH8OxP8d1OFgxATpT0fQFwxcJkawM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KF09lCx4; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KF09lCx4"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH1MC1021885;
	Wed, 13 Nov 2024 18:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	//gaAWERhApZUreOl0dTZpwSw/WmhQeQFk2iFFDdtpk=; b=KF09lCx4VjkxU9AB
	91V1iSLjcNoFqF/WS1STGC5q1tGM0H+Dc8ln6FjmQdTeUrnveltL2k+1fm8svQhn
	eh9WG6tRptL4ruhItyW7Tg1JIZPRcu/zYOjKauhJJ4/r8tXeMD6qPVM7MTN7awau
	590HWs/w9lJ0euNFIRaD/Rn93FBZVP5QHQpljp/R/gwp5M4HJopZCv8vpD/4r/Ii
	Dn+gbKEFNsVD/PJq2Lfq6o3IHDIzGiBjTW8cNBcSyOaQ5jvTgxSbjA3jNjwLtIYL
	tzuDu3wzDlxsrNX7x2rc4s7T0I4KSR8QO52iOdO0EPblmFS5h6K6SNwimzc38leb
	In/Nkg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010006.outbound.protection.outlook.com [40.93.10.6])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v47y50k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 18:34:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N825svISD80fBWigsD0CWZ63hY5V3bgugaZHp4QT84SS065d1nYFnB12tMy+HkCCdMlWOixx+tJs5s5EezdZ4zpTW/E2jDGkXMse4N/FNfZ316mAOP1DXLKyy+090qkvYzhJrdgHPeAJ4OAVwAC+Q7zrStALyJwxsjqtAVfL2izssusd0lydVvCUL6h+Pb+9lt8LxVzQMWjWnf3CF+Ix6Hpo8Faie3UNxLUKqIigIIkAcqxWBRZxPIJd5Pkfii+BIJLPkTG0RKTziAKql3yG3UnRNF3FMvodDs5THNQoOAYjO7GU+hT47yQTZ9Evh3g9i7VwVSGueFq1IuEvnvEHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//gaAWERhApZUreOl0dTZpwSw/WmhQeQFk2iFFDdtpk=;
 b=WHZaX8g692+1DD746QFGAu46c+BJ5r/u89Bon91Uxw7FZOYaA0Jz7PzY062yCYKTt+KC6utrdhOn4EkiRTJMutVVz3tg9EWuwAR0sUYMn81xe2DewsSFwnmC+TcStZUelRDEI1HCiCVdmYEGF+ir6R/w+fqMwFwl8UtXXHnNAvw49Ggq1jHKsG/SKCFWAfpcT4Aes+0y0j7pA9FTHJ6h0NBFJhtePzOfWETQ1sLnvtbEm1iYeqArRxRl5HPexZydDMouDcNddKUDqn/HL3eqCqfILatQWPZqRScXeJKFAOFaZmdT/ZRNSRNbDphY8fg8WodAWviGuyjRI6M70TYOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DS0PR02MB10250.namprd02.prod.outlook.com (2603:10b6:8:192::5)
 by BL3PR02MB8020.namprd02.prod.outlook.com (2603:10b6:208:35b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 18:34:15 +0000
Received: from DS0PR02MB10250.namprd02.prod.outlook.com
 ([fe80::3df9:2304:93de:72ea]) by DS0PR02MB10250.namprd02.prod.outlook.com
 ([fe80::3df9:2304:93de:72ea%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 18:34:15 +0000
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
Thread-Index: AQHbNYJkEqqIKaFdX0eC3yeaL8Dbd7K1QEgggABHgYCAAAEX8A==
Date: Wed, 13 Nov 2024 18:34:15 +0000
Message-ID:
 <DS0PR02MB102504C35F7F82A71261B9381B85A2@DS0PR02MB10250.namprd02.prod.outlook.com>
References: <20241113041319.GA158543@thelio-3990X>
 <DS0PR02MB1025072B87B225A4A8F0953F5B85A2@DS0PR02MB10250.namprd02.prod.outlook.com>
 <20241113182523.GA2701299@thelio-3990X>
In-Reply-To: <20241113182523.GA2701299@thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB10250:EE_|BL3PR02MB8020:EE_
x-ms-office365-filtering-correlation-id: 6ccfe490-8a4e-4692-b948-08dd0411c70f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UWc148ZAEPoecRV//o5IDfwAtjKRAVUNhhlMyPxBoW/osna5SOYnwNf8bKck?=
 =?us-ascii?Q?0C71UgKf1+l0RQQ+0FbpmyHdka3fgFiPFREhtDBZjcg4tU51C9N8uoi7jdrm?=
 =?us-ascii?Q?HTIvXdO7dPRmAV0mPbvCuR1fo95ZHxl6lUdK+Nvi1LdXpOy5s6sLAT9OUgGN?=
 =?us-ascii?Q?mKii5GTywFgRk1j+Ms7CV6EkiOut6u/Z6ze1DNax31j3Qp/zM0eavMB502ye?=
 =?us-ascii?Q?TTbwS2PtySyxWXNrsnmwj3NI0ONRAxO2h5WgHLDHDY4gxwmWNk0ga3qMLHjf?=
 =?us-ascii?Q?N7VYQU6Lcdg6bbtTQv12w6knVbAxKi9GQZtzuc8DOKiilmh8V304RBSuWnVm?=
 =?us-ascii?Q?45nWINvEiG4UjiWq8MmG7c8zlACRGmNaEuDkG76g+WMobR0L1zW4UNhpRJ/l?=
 =?us-ascii?Q?ZEYyADJFi3wlWO7SMdXOQcl8uy3iDW7b3Dj0WDD3fdDkIr1g7RRnimjRK+2S?=
 =?us-ascii?Q?92gWPDc8igUYENiKTwVtOH2cyrEhZN7Aat6HkjH2SbzlBwCsyFn4Wry1rMsY?=
 =?us-ascii?Q?tAdpDI5S/xwpGIkV4OLikKzn/bF5ft5VAF4JdMuqrDa0QirtQ2u/+qNLSWeN?=
 =?us-ascii?Q?9wuRi2Xr+87hOLW3UDw9kWkngwDRN8Y0UIefb9GMAZfJc7iuNrl34FhzwVD1?=
 =?us-ascii?Q?bc7Hw61SthfQ4tKfnOjx4NhihzaXafkkC6H+lTVzD2IlUnmuxp8CuGHop9Zl?=
 =?us-ascii?Q?j5meTwTGGpKXZHnZYMkWoYXeJJzFvnR5uUvfV/+tYH92jboZjaMM5P6NIzbU?=
 =?us-ascii?Q?3ACYQLgDs2SKdLP4M4bEvVsJq+qzcB/kdsM4PVZTK3golwbNMih88tj14OdF?=
 =?us-ascii?Q?5GW7JjiMmaPsCp6fyScfk5eBpmfwTHJKzCOdQ2tRwX0rIoPw8QIWPY21mqxB?=
 =?us-ascii?Q?3hJkeATN2WogMjN89eoUegJm9Nfc2A814+1uamyfYAh6n7xYyPgnNM7KuES9?=
 =?us-ascii?Q?ZgqMDxWvySZTow6msQjSCLFOf7oS5UQvWE3NAMxuNiWOqvdzGAkbRYE+7tgn?=
 =?us-ascii?Q?BDCnmCigpmqecj2ZpW4znTH1Qu+YoLjLwe8cPYDrudZIGcbRNnNTN0fCix0G?=
 =?us-ascii?Q?yN2amSixT9UsEcl8ZLiEZPX+0EEQH9MdPzXviZvUjLjlm4ty75vhxRG1mGaX?=
 =?us-ascii?Q?fvH/avBAjUQMdMnVpZjr7DYmMUPeWP1QOngMkwNIWmalc6Qp+17DQ9DD3Vdx?=
 =?us-ascii?Q?Ii3ka8AO4KBAN4GP3wv3nsSr6IDdX7rSPDRWIqz9UxluaB122byjjm3EdTJO?=
 =?us-ascii?Q?Ks/WLmS9JUyGDN4vU5DvlDYSnMLmsImaOng0smFpS2XnjmSS88f78naPA/Gl?=
 =?us-ascii?Q?W/or9kbvCuRcTPtbsU3GXASMzkqKK8PMkJ6RmZyLuSuSzHVPAwFkKflJ7aEr?=
 =?us-ascii?Q?SSGeP8DMpRP5wLz2qAm5cU6EqOoy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR02MB10250.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gNKdhVmjjh/s4lv2CFw9mPwgHpTWAGliVijrm1ZT+OE3j+x/qdZIMg0THJ6g?=
 =?us-ascii?Q?axCEJtVFxXNzOMpWF8IF+BcqS0/yhD4U/Mgw/vaReGU/KrqfixWZazmRQpsR?=
 =?us-ascii?Q?tQ3HMV4w+PRqumQ6ZjOICXlYVSFZrmquLnYc1IfRYdUp4s7+VLQOxw5FONZb?=
 =?us-ascii?Q?SPWAE81QuUIhv1fAcdDHT+P2C5y/4t1j+qU5HxIESpk53q4VKKobz1Y3ePyk?=
 =?us-ascii?Q?HfOXjE+VIiJ5QMq8ZeblMqrtX9nIvudiePO5zNhx6Y6EM0YSBwIFu9ZcWjIw?=
 =?us-ascii?Q?JylVFz2tsAuu0qLZZ6YC9Tlw9fLUvmY1otzd142Yvtm9zvN10xQZ69wcZTp3?=
 =?us-ascii?Q?kE6bfQeYhymtDapzEoUPvCpPrde+ki1bh4QpoO1bQKoWN9tE8PUw8ME2o1r3?=
 =?us-ascii?Q?NhDXLSX2O/qE003ebDhkd/Gc3vCvHq0HD+i86NskG+chu4X5fzOV5UF20RNr?=
 =?us-ascii?Q?ckxV+/a4sjBM5ENLjdhPPh45orEJejkIP0+afdk56jhGFAxvOBDUj0dwOqKO?=
 =?us-ascii?Q?UAg4A28ViqrYoA64L2KIQT3HAPMmCf1sH0YY9RG5kzbGitYaaSaEacIRHy/Z?=
 =?us-ascii?Q?bS99SbRaqyQ1QaOVusDWUdeduOSD3J6AaI2q8zqKuhaA48JOLmj4wAOqoNDT?=
 =?us-ascii?Q?TMoG21q4RyZXu7dPucGAuLPB6N+7QpwcUInNrPrXRf6GbIsYGfTLdJD3bRZg?=
 =?us-ascii?Q?DzgTfugyGOWMfNVBAY4lw9i/yUQjlj/W+/Jzmd6WkML4u4PCIj9GzPPaAjKi?=
 =?us-ascii?Q?Ql3WHPvjB8IsxXSjJuXQV9Q01eucgkVA75SbY9b5tylRTHvgja+13oTk2HDS?=
 =?us-ascii?Q?oXelIVxSbfMAwX/wa0ggmY64AzHMZO4XDSpLPF42I+zxB+8JdQqRsO5yHf1r?=
 =?us-ascii?Q?uhuEr51zJm0FUxC8XxDJQ3xLVeic6xZGI1lBZY9r5ruf4zyUSxRKzcY75CwH?=
 =?us-ascii?Q?CS6lsNnQaGeOKTsZ7fA+0pfMJ+L3o7ZtdhmhFbcUyD5s6E2Lu+wieEmjdvS2?=
 =?us-ascii?Q?OIihEMSce6LWkpvCNIr7KVl8m2Rk7iFskJqSjRwkx3/MRYCLB7g1Al+dC1Cr?=
 =?us-ascii?Q?n2g6eVYypeHG7lYCeydtm0jJIT/AcFKQDjciOf0KjnSgJLga4ekKLRwiuGxY?=
 =?us-ascii?Q?O3X7VsAmAQDQQtBy2DDnKI5ZpI/UyD9CxU7a0yq6Jn+SMmhXekzWvitfZnZX?=
 =?us-ascii?Q?FQTRl5KTCLfyamJ494swg/2nSvd24dWcj7UiqE4AkUYbM4ZHP5pxQnrTFUNs?=
 =?us-ascii?Q?Sgdr/hcKJAsRW74G4ob4E352TjDUzqQAwThZcrkL2gZeXQeWcy1OOe5RN+YX?=
 =?us-ascii?Q?FI3giLBPDt8zURJnema1Stm+bKNwQVMDj+nEBbqBG+ArAZ7nEu33r3byhdU/?=
 =?us-ascii?Q?urxCudNTyc9akmuMdRVnJbdmAumICtKSYaiO0wVI4wRq9fzFFu/VtvUM5Gj/?=
 =?us-ascii?Q?XRVd2uNYD9Dr8RD/JAoNoPu5nZc1/0/UxpkUpL4cxSI6DQiMhGrkmauY1D9H?=
 =?us-ascii?Q?Lt01zLb3jtC6PlVbTzhlVRKOEg5+aB6DcU4PWT3r2vgdr4KbVsuzPgtK50ja?=
 =?us-ascii?Q?4pxgUWk5ZJYT/0jjgI0=3D?=
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
	RAYkrfI0lS80i/6dL2L5a7vkBaeY8Xb3dYNd2aGl/pucMYAc9g/FHSjbBZtyhgROnTN4bhDYf9JPpVsutK6ts3JQ6sQcllJtOkGgMcRRc4OF09niEhQF2Ofy9E7dK4wdR4S+q/WPPjiciWwMnic6ZSFucIChcUMXnFh2H1UL2346KLgsVKkBwpqdrvk9MqvH95ftcWhNvx13qtA9EYC79tNzkOYr147sOFiKg6YnKA8iKcfk/L4QHhVZzXyFdn8ovHtBtg3TsgYKH6huLuAtNX9A6zUP2T7GxMg+LE0fzbsO0XWZWbmy2Fo1nsSkGYDgDBeIoXmazO6BYOtRqVo1OOy8dqjHvnAnxotcaHBuOhylPX2tdycYy8l1BPHA8+an+feYFK8GC9v+tm/ENARMY/1/+nU9Coby3EclpOJQ3yUzPxsJpEDDkUmeZYFLcKD10TH9HycbitZZq8VSOtsF70AShOdZOYJV5A3xWFCYcUgtjydoUlAqRjSXIEjFQne6Vv9XaszSgdmmSkknd3rfJuccXBakiHi41d3UHOwdI+OYGGWD6dAR6tuQlPpNFhs/ha4a+rDnFLrt8xjeL8UJF3iTcf5npOAUS4FvufIirh5PQzmXi6GC6IrYHLrc0e1O
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB10250.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccfe490-8a4e-4692-b948-08dd0411c70f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 18:34:15.6581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7O7Rh6K4YsvbjOvmc6e+NtJ+XN9jDQaQmtn+n3Aa3Sp4WQ8gIkbG4oenfGOQAlquakriSi4YN4mR9nXsWm3CHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8020
X-Proofpoint-ORIG-GUID: JGaF1eeY77Dz2M8ZC3IpsfJGW9m2It7-
X-Proofpoint-GUID: JGaF1eeY77Dz2M8ZC3IpsfJGW9m2It7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130152

> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: Wednesday, November 13, 2024 12:25 PM
> To: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org; llvm@lists.linux.dev; Alexey Karyakin
> <akaryaki@quicinc.com>; Sid Manning <sidneym@quicinc.com>; Sundeep
> Kushwaha <sundeepk@quicinc.com>; Shankar Kalpathi Easwaran
> <seaswara@quicinc.com>
> Subject: Re: allmodconfig link failure on -next (relocation R_HEX_B22_PCR=
EL
> out of range)
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> On Wed, Nov 13, 2024 at 02:18:03PM +0000, Brian Cain wrote:
> > >   ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x=
160):
> > > relocation R_HEX_B22_PCREL out of range: 2098032 is not in [-2097152,
> > > 2097151]; references 'memset'
> > >   >>> defined in vmlinux.a(arch/hexagon/lib/memset.o)
> >
> > This error seems to be due to an incorrect range calculation for this
> > and other relocations.  Alexey has a PR for lld under review
> > https://github.com/llvm/llvm-project/pull/115925
>=20
> Thanks! This does appear to resolve this particular problem for me. Will
> that need to be backported?

I was hoping/planning to request it to be cherry-picked to 19.1.x once it l=
ands on main - are you asking for branches older than that too?  This linke=
r problem has been there "forever" but I suppose the compiler only recently=
 made a change that makes it more apparent.

Sid and I have discussed whether it makes sense to change these calls in th=
e kernel to be extended.  That might be a good idea, but it's not without d=
rawbacks.

> > In addition, since our initial hexagon port landed, lld has added
> > support for range thunks.  And Alexey and I have a PR for that too
> > https://github.com/llvm/llvm-project/pull/111217 - this should make us
> > generally more robust in the case of larger executable images.
>=20
> Good to hear!
>=20
> > > As an aside, do you folks working on Hexagon do any sort of validatio=
n
> > > of the kernel and toolchain? I feel like I have run into a decent num=
ber
> > > of Hexagon-specific issues this year and I am curious if any of these
> > > things have been caught by any testing that you might be doing.
> >
> > We don't do enough testing of the toolchain changes with regard to the
> > kernel.  I think we have room to improve there.  I'd like to
> > incorporate more testing into our workflow for landing changes in
> > upstream LLVM.
>=20
> I see you made some comments on this downstream but if you want any
> input or help, I am happy to provide it.

Thanks, Nathan!  I will include you on our discussions/progress here.

-Brian
