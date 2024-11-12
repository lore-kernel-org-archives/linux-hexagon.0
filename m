Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C7205150;
	Tue, 12 Nov 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428387; cv=fail; b=PSDBWrMINmlosGIPStkWPHbWWkFTrIFYLh9ir3YMyBBgTD3jF2qeYu/bL+6Hp0HZJIcjfERvL/v4gf05JuyUlAh6JePt6xCfUKfFm5QJ5q1BuPoIm6QAlPNMUfUvwIGweKEHFStWJryQJGJN2C6JyNN9sXmDqWLTocy9IDez3U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428387; c=relaxed/simple;
	bh=KQxc61IvUnvSNGnlwimNGxxSHMOEi865phsRdHzCUKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HlHG3DTjAFNEepZTZApvfuhuYKjU+zKXkR07sVx8XIaOmpG8BOKdVd5tsif1sURzzLgMz03qH5kyef2kZVzweD3NazeZ2dOVgEAjtlZEBCNBSsn2ahswCFnPBDyENhGfJg/K4qWIF+CrxwPa9zsd3CwfovwoAWhN2H7tAE0DgNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TkzI57VW; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TkzI57VW"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFpv0V004247;
	Tue, 12 Nov 2024 16:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FgAS2ifKm/umvjfFfOug32gmr8gqifPiKPKTPOjeqag=; b=TkzI57VWVayifTaS
	oYJwR9CTYuEA6LlsD/0zwQqik/irPjVnHC+EBhC/0I4ORCajFIfW5w3QkvhFR3g7
	1Klakf450N0o81V2EGb0GnpYdkMEexWPq9T6mTg3gKgI8E6QmxL2kyuIIJYiHNcM
	dJYoCgKi8PmQCx9ocE1sYhgtNQxiM+W3Lr41mFNCL3PEj7O0z9og1BlO+Jg/dJo0
	+gHtPPUASMYqeeqwayw1PF1KvYt71Ivni2sigoUIFnrp64m5INjd8yJGZ1aQAl9J
	84XxMQ2FVd/bblinFc0ncx/t4rtwGGIb3gWznomYkyesjSjPd4vva8gcIA3WaGpD
	HQXW6g==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v1h6hn8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 16:19:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bo9SGdszvrv92YsFfZGe6ZoChwvX6MK6KiAkHS8eiGmpeQGu2HvGbelKmjxeOWRfa8gwk2xvXh+MaPAiUY8lxaLJ++tdEj0vhZ4JFyjtH70ttNN6D5iA8vjf1MNQAR/VZt4uRWk/ZuPscMIqGHHPfQgXi9qcARHoRlTFOUc9PM9h+GcaWzG7Uj5OLnsN+tVA7BV71e24BXGVxjQ9sMNgEbRv9Qk/vr5UbIzskj/jNigzPFGkbIAvhTajrruk3j8pBRwluwUyWRPFY6r4t/mhZCNmFtjo5yb/1CgRdwoJIqIIL/DgctdNUcUJldJeC/kscPlBLYZ5L27ie3AhCTGDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgAS2ifKm/umvjfFfOug32gmr8gqifPiKPKTPOjeqag=;
 b=WvT9rhg3nEXgKpa1h1Avz6p/27OkP77ueyxG/J0pW/S04lh7SXlW310xWTwFKv5VSvsnAZJNHNiRJ6KDprDuXt/+OZPSowr/rrIHW9SRnr8dieNPpBObEFmW9VBcqltuwtpN7g2+2JYEPQKQFpoH1zwYjHDNJ0IgN4VnPUbdPUVKuucO3ysYaoKRc/jKipOYFQGit+5u+Zy/TTGnYPiCbfRGwIJaVr/wBuPA07tDJkjOxT4Orlv5tz5FslNVwkLq5cExc8rxxH5rW8mom1uXXjY8WB+bir80M4GZ6C6zeHrOlvdyA5v+7cg/TE7Hrb3GqT+wsu+ECvHYu9huyJchrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DS0PR02MB10250.namprd02.prod.outlook.com (2603:10b6:8:192::5)
 by MW4PR02MB7268.namprd02.prod.outlook.com (2603:10b6:303:78::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 16:19:33 +0000
Received: from DS0PR02MB10250.namprd02.prod.outlook.com
 ([fe80::3df9:2304:93de:72ea]) by DS0PR02MB10250.namprd02.prod.outlook.com
 ([fe80::3df9:2304:93de:72ea%4]) with mapi id 15.20.8137.022; Tue, 12 Nov 2024
 16:19:33 +0000
From: Brian Cain <bcain@quicinc.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: Nathan Chancellor <nathan@kernel.org>,
        "linux-hexagon@vger.kernel.org"
	<linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sid Manning <sidneym@quicinc.com>
Subject: RE: [PATCH] hexagon: time: Remove redundant null check for resource
Thread-Topic: [PATCH] hexagon: time: Remove redundant null check for resource
Thread-Index: AQHbNEWS/tqDyu5UiUSZ+sUFcC0fc7Kz0WPw
Date: Tue, 12 Nov 2024 16:19:33 +0000
Message-ID:
 <DS0PR02MB10250A0BFDC4427C980A29CC1B8592@DS0PR02MB10250.namprd02.prod.outlook.com>
References: <20241111142458.67854-1-hardevsinh.palaniya@siliconsignals.io>
In-Reply-To: <20241111142458.67854-1-hardevsinh.palaniya@siliconsignals.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB10250:EE_|MW4PR02MB7268:EE_
x-ms-office365-filtering-correlation-id: e7604414-4582-4f39-0af2-08dd0335cb1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IkTQd/H1U8hLS44rVUQQ4ELptNv2WAxvb6AgDMsKL0/l3MUPDw8WCTBu79YW?=
 =?us-ascii?Q?1xJEsxXyUTLsdebVFc85/i5YvtRmV1V3M7PNnXzpTegYIhP9NRt7Rrhjd2D3?=
 =?us-ascii?Q?5b+sFqZewNBViHcW44Ex0ncjpRtV9sTuKtfATtUyciJbYa3Tc/yztLrs0nYw?=
 =?us-ascii?Q?SPCfPSbQiiKtFKanhwt6S3IS1AG/jcq9Oo1Y6HGVbd1WJLIToF2GRoMjSlJK?=
 =?us-ascii?Q?7ToJ5EO+ej74uC3k8QKv1P1SulnYg2xofRu62sAzByn1umyU2yld7/YE9YkJ?=
 =?us-ascii?Q?EkvTGmGOpbTwRYyh+t8OV4GeDtgaKe72/jnj8/e2icRH0+82scOP3W6F4mNG?=
 =?us-ascii?Q?Q/ry7QXkTfNO5u8xqqf07fqActKtK71KB20GNnGrGUjghP/8mPLs/mBlreSx?=
 =?us-ascii?Q?AvN+0QoKkCgdU9hvUYHHNTl645RIxM71keRPFRSpmCqU2RVrxHEJBYrR96w4?=
 =?us-ascii?Q?UFTED9u4iZe6XFIdn+c+k3ZnWDQt11iLcuAd8YoHFAbe18TcmNcT6BYXg5Hb?=
 =?us-ascii?Q?/CXb/QWHZonDpKZXh1WVFrz8uItLK/5t5Kj8ZYUcFu9RcDyUuKP6qDljQNfm?=
 =?us-ascii?Q?yQCyZlO0tT/PlrbWBpQ2Q1jAzTBnua7SQ2Gs7AlBdO5Q7lUOmNhH5y4Sz4zk?=
 =?us-ascii?Q?EHJXs0CKpzvznuKzuvonfsbIpkcXfFG+kKQ8faXvPQvJiqDhXIN9UtTZOooX?=
 =?us-ascii?Q?RW70IMmHV9nZH04j2dls0y7Ox87VzLF19LkBzIHBMHud8B8jOKMcV/AfToIz?=
 =?us-ascii?Q?2txiji1vCZknJ6hs6MK6FjDmakg9X8kUmgXGsDQObZKdLerGK31zNMakeXwK?=
 =?us-ascii?Q?sBjd5EVMlZM8wjlP5LmXZRjHzCWTG/BN0Yy8YqtVOFtrtrESDeydSz/kZtLB?=
 =?us-ascii?Q?y9G1mp4njBjOQySyS/9NDtWYiJRwSSbRm7PVBq4PnwUiLgU0hETBj9/ymiTL?=
 =?us-ascii?Q?idXchSYUG8fmhRiS0ypc5HyeoYUHpdprHOsLmSslOaX+SbV20E5qrF+vRiUs?=
 =?us-ascii?Q?hNJX0QBl3sFvlovTLYURhGymlo6evJsyO+lPvb08+HLiBBs1AxsQ8gb5vH77?=
 =?us-ascii?Q?0FNEq56L7UjYuyMjKMBEEbdBAEMNY8Tl2iqD3s/CtWc4inTDNALIBesa02RT?=
 =?us-ascii?Q?xHAU6JkN43Ax5+ERiMJHNg5FQko0YZaXcYwxSNeN84GUjfcTAf/GqvqpRitn?=
 =?us-ascii?Q?Yim5gOzxgD8tuDmxQhxEdnMld1sC454fATzN+OROIO2NWFaZlyf9NqiYNFrr?=
 =?us-ascii?Q?d0cpiLERAzzzUCY1iXk5zClSJcEpQOD6xjre4wfucQn5yosLMayKpbNLQfQm?=
 =?us-ascii?Q?C90sZ0/dGCihihbh7rrHT6k6F3P14tyAhX1SmwEB9434tber58h92/xQHKgP?=
 =?us-ascii?Q?qtt7YLA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR02MB10250.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gvEHYUXz6bYIrHT/k5jtBF9+OQGe8eqT8d1mtP5NJ6sRIkBWtQCL1hbZ/UXc?=
 =?us-ascii?Q?6qZjcWIpkO20nvbF2cOHPCuGU8IoSuW1aqie4P5Vkj5vdvdnBup2yvq9jakg?=
 =?us-ascii?Q?l03uW+8HSEECJGq/hI1EbT35EMovOPK0d3ekD2YTYhafllkVjLECsHSvljBK?=
 =?us-ascii?Q?kS1yngnlezb75TXtH7w2hsZrJKyDtXwepOkzqLPcZvIGBkPMnp9IS20MZ8JS?=
 =?us-ascii?Q?xazVIJ8pFgfc8gtPgCQaywAHCQCHfvFeJOeDT2uA6dFDuK94pmF7EZhQKpn4?=
 =?us-ascii?Q?N5YAnYw6q4W79+PHDDWs9DQddPzT87U4p4rBJnDnBVEyxiAoEVNDv8OdO0zs?=
 =?us-ascii?Q?5ri261kcyEisZ/tPlCiYAJ3JzoRdASfwW7X1xXpeR02rTCQq50zoP9/PyKSN?=
 =?us-ascii?Q?yeZnsjXUZoEcEKbWvMWGhKRXBQg/AckYGAfqC4m/mB0HlIMnoV6wu7HgZkZb?=
 =?us-ascii?Q?8C9+blgtT408/VyyzJ2SLU0HD7RE3i4fhoBNr4f16WzRuR6KpNUBN7sLBuXY?=
 =?us-ascii?Q?Yj9VP0qLJuWdodfsfVhZVNcxWaAzME9uoGyjntq1fKw86Jr97IhZsUsbDu+X?=
 =?us-ascii?Q?fXnoPQ8GmHhEeApmZw9luaYq0YO+M8MnbEU4r+gNk56Dlh2WmD7uoEoKiDfk?=
 =?us-ascii?Q?TMwu1Ngr/1rjDt1EIyJNZ8gDkaPDkmKlXQ2V2M+w4hl7hQSuXKk9f4cAEazA?=
 =?us-ascii?Q?We7JmdoZNG0lB9TO/V6u5nB5HMYXDcGO1wy621ZQp2GfsY+yWImnTN65aC8c?=
 =?us-ascii?Q?r71uYaF1eUH3xGtt+DZV7qd6Fm3uMklP/t1H5jPI+TpgUVtcAufF8JPXuw2w?=
 =?us-ascii?Q?Id8S3ZrjaLb10vFwwmWuscrDWcU24T5ucdOhq2S/WFQyyGvU5WGq0Zlx/Glg?=
 =?us-ascii?Q?vSAtKz+L7f1pVtODopoD9FnhcKrISS51ldK9lODZ2S9xTLLm2A8U5K9Wur5O?=
 =?us-ascii?Q?T7p0cm/a//bLMQnzmHUaa9BX82Mgq9vrCarsiHvaoVI2AXy3qy36feXqlRiH?=
 =?us-ascii?Q?mTG27L7TpF1IgzfrDqcimVMMeoFQwT8BC6AVCfyzePUqzr2IM8lTrBQaijN7?=
 =?us-ascii?Q?eMdOgbzM6dpyMZlfJUrYm6JjwfUmJjcvUjL0YRUpXTeX66muRn7lECeVs//X?=
 =?us-ascii?Q?Sffm9ZhrKGUlWDJFuzwauknMEJvyZUcFqiDc9Rbv9ldJw7NJ0e7jh2F3wXFS?=
 =?us-ascii?Q?LLieC8xaPnKQCHrbHcSXITnNyehZ2Hr9kMENAPwd3mPsI2/HP/8v6FcyQln+?=
 =?us-ascii?Q?pQ4oa5iaWh8BBQtEu8N3rc0U5+mylUP7yMSaMTDmBPBlPGdSJCDUTH5AuMNc?=
 =?us-ascii?Q?ptStnbhdWKtzs1BDKO6XdLLghqKua81o1IB2EXP+Vlol+K1pdWH5iuHTO+Qz?=
 =?us-ascii?Q?fk8UzRR/bImk0d2mBxNfBQUBp4rdNrG7aqLTjDBRT7Qp+4bawIV2huDmBcuw?=
 =?us-ascii?Q?45bUrimtS0tnSKhDsMsPppgV7AP2bX5pmzom3jNRKbC5mpW4s9IYejYoC2BG?=
 =?us-ascii?Q?C3zJiQe/dJlEsYyMHC4Lfbn4N5Y8Z4TQ07exaXKp1uI1fiwSYmkGxtSAKVCn?=
 =?us-ascii?Q?7scf/KE6MKYlm70VDvkqE6U6bwl2VvDtDhlWmnIu?=
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
	vBf5oRSsdziWR/uoYuVTgsxcEkS4ai/h14wPvwWTj4jWV1e3IEiEwU2TryHoHOaqAVjzKpvzr17TT/pa8vr+Zp+AXhlud9YwivaCJ1thCILhkZYjEuC82VDueXCnLNadxQOjSH6ufpCK/IggwrRq99V9WEuZPnpM9M8j+Bxlocf6R3wH6V1Nht8bmZx8Ih1huu9hQ2IY54Gc/tRM2hVbfxVNkoNS8wn4TiBz7QIztkLZaY8rLBy7W/RFrWefvtVE0rbTFwTWgP+TUck6VUdc40alHfLBgt8W0hIxqcq3uA/u7BUWPptykDFm2mWSUMQk+5Lb8kvS4hoGbHqdXEAhVtmhCq9uoxompC8BqozuSifcYPmZYiNTgp/dnvEzkvIeojVg+DjMBqugLsc4P1aQ7cKGOnwszDltLaYdeEWPwWGarnM88cX4bK+anTO0aHWfJU5dKc7vNmzeagCUyzXZa+OQSVOLQ1nTcamfKpGhEPmXlqanXQ1egi9BhdVryBMdJbogcgCCD1wp44SDedn3C4dksPYsfGWDf85u0xeZCi9+zUaJwKTQq36lkHNO/D1zENi3U8YTO4HCzIB94ZxrRJx3DUNLoglCOW40OENOxul7Ybg1h8mLT3T3W4e7qE8N
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB10250.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7604414-4582-4f39-0af2-08dd0335cb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 16:19:33.1940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2iiHMg5PT/B+V2DgsHDtMIvRKgfTvrpzc5kXBHANuttrv5CDqhyGZPE0B7VL2xHtDc0YguGiDcl2hkbweundw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7268
X-Proofpoint-ORIG-GUID: XO9ujxMYTRNLROeKlrrved5s7_nX-Ltd
X-Proofpoint-GUID: XO9ujxMYTRNLROeKlrrved5s7_nX-Ltd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=874
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120130


> -----Original Message-----
> From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> Sent: Monday, November 11, 2024 8:24 AM
> To: akpm@linux-foundation.org; Brian Cain <bcain@quicinc.com>
> Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>; Nathan
> Chancellor <nathan@kernel.org>; linux-hexagon@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] hexagon: time: Remove redundant null check for resource
>=20
>=20
> Null check for 'resource' before assignment is unnecessary because the
> variable 'resource' is initialized to NULL at the beginning of the functi=
on.
>=20
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io=
>
> ---

Acked-by: Brian Cain <bcain@quicinc.com>

>  arch/hexagon/kernel/time.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
> index f0f207e2a694..6f851e1cd4ee 100644
> --- a/arch/hexagon/kernel/time.c
> +++ b/arch/hexagon/kernel/time.c
> @@ -170,8 +170,7 @@ static void __init time_init_deferred(void)
>=20
>         ce_dev->cpumask =3D cpu_all_mask;
>=20
> -       if (!resource)
> -               resource =3D rtos_timer_device.resource;
> +       resource =3D rtos_timer_device.resource;
>=20
>         /*  ioremap here means this has to run later, after paging init  =
*/
>         rtos_timer =3D ioremap(resource->start, resource_size(resource));
> --
> 2.43.0

